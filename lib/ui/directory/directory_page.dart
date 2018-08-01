import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/directory/directory_actions.dart';
import 'package:flutter_app/ui/common/info_message_view.dart';
import 'package:flutter_app/ui/directory/directory_grid.dart';
import 'package:flutter_app/ui/directory/directory_page_view_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:path/path.dart';

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
        builder: (_, viewModel) => new CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text(basename(path)),
                trailing: Material(
                    child: IconButton(
                        icon: Icon(
                          Icons.sort,
                          color: CupertinoColors.activeBlue,
                        ),
                        onPressed: null)),
              ),
              child: new CustomScrollView(
                slivers: <Widget>[
                  CupertinoRefreshControl(onRefresh: () {
                    var store = StoreProvider.of<AppState>(context);
                    final action =
                        RefreshDirectoryAction(drive: drive, path: path);
                    store.dispatch(action);
                    return action.completer.future;
                  }),
                  new SliverSafeArea(
                    // Top safe area is consumed by the navigation bar.
                    sliver: DirectoryPageSliver(viewModel),
                  ),
                ],
              ),
            ));
  }
}

class DirectoryPageSliver extends StatelessWidget {
  DirectoryPageSliver(this.viewModel);

  final DirectoryPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel.status == LoadingStatus.success) {
      return DirectoryGridSliver(
        drive: viewModel.drive,
        path: viewModel.path,
        content: viewModel.content,
        downloadFileCallback: viewModel.downloadFile,
      );
    }
    if (viewModel.status == LoadingStatus.error) {
      return SliverFillRemaining(
          child: ErrorView(
        description: 'Error loading directory.',
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
