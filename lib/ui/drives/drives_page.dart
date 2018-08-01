import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/drive/drive_actions.dart';
import 'package:flutter_app/ui/common/info_message_view.dart';
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
        builder: (_, viewModel) =>
        new Scaffold(
            body: RefreshIndicator(
              onRefresh: () {
                var store = StoreProvider.of<AppState>(context);
                final action = RefreshDrivesAction();
                store.dispatch(action);
                return action.completer.future;
              },
              child: new CustomScrollView(
                slivers: <Widget>[
                  const CupertinoSliverNavigationBar(
                    largeTitle: Text("Drives"),
                  ),
                  new SliverSafeArea(
                      top: false,
                      // Top safe area is consumed by the navigation bar.
                      sliver: DrivesPageSliver(viewModel)),
                ],
              ),
            )));
  }
}

class DrivesPageSliver extends StatelessWidget {
  DrivesPageSliver(this.viewModel);

  final DrivesPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel.status == LoadingStatus.success) {
      return DriveList(
        drives: viewModel.drives,
        onReloadCallback: viewModel.refreshDrives,
      );
    }
    if (viewModel.status == LoadingStatus.error) {
      return SliverFillRemaining(
          child: ErrorView(
        description: 'Error loading drives.',
        onRetry: null,
      ));
    }

    return SliverFillRemaining(
      child: Padding(
        child: Text(
          "Loading...",
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.all(16.0),
      ),
    );
  }
}
