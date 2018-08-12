import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/ui/common/info_message_view.dart';
import 'package:flutter_app/ui/common/loading_view.dart';
import 'package:flutter_app/ui/drives/drive_list.dart';
import 'package:flutter_app/ui/drives/drives_page_view_model.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DrivesPage extends StatelessWidget {
  DrivesPage();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DrivesPageViewModel>(
      distinct: true,
      converter: (store) => DrivesPageViewModel.fromStore(store),
      builder: (_, viewModel) => DrivesPageContent(viewModel),
    );
  }
}

class DrivesPageContent extends StatelessWidget {
  DrivesPageContent(this.viewModel);

  final DrivesPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      status: viewModel.status,
      loadingContent: Text("Loading..."),
      errorContent: ErrorView(
        description: 'Error loading events.',
        onRetry: viewModel.refreshDrives,
      ),
      successContent: DriveList(
        drives: viewModel.drives,
        onReloadCallback: viewModel.refreshDrives,
      ),
    );
  }
}
