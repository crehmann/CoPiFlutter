import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/ui/common/info_message_view.dart';
import 'package:flutter_app/ui/common/loading_view.dart';
import 'package:flutter_app/ui/common/platform_adaptive_progress_indicator.dart';
import 'package:flutter_app/ui/directory/directory_grid.dart';
import 'package:flutter_app/ui/directory/directory_page_view_model.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DirectoryPage extends StatelessWidget {
  DirectoryPage(this.drive, this.path);

  final Drive drive;
  final String path;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DirectoryPageViewModel>(
      distinct: true,
      converter: (store) =>
          DirectoryPageViewModel.fromStore(store, drive, path),
      builder: (_, viewModel) => DirectoryPageContent(viewModel),
    );
  }
}

class DirectoryPageContent extends StatelessWidget {
  DirectoryPageContent(this.viewModel);

  final DirectoryPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      status: viewModel.status,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'Error loading directory.',
        onRetry: viewModel.refreshDirectory,
      ),
      successContent: DirectoryGrid(
        content: viewModel.content,
        onReloadCallback: viewModel.refreshDirectory,
        downloadFileCallback: viewModel.downloadFile,
      ),
    );
  }
}
