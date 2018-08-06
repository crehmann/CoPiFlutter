import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/directory/directory_actions.dart';
import 'package:flutter_app/redux/directory/directory_sorting.dart';
import 'package:flutter_app/ui/common/info_message_view.dart';
import 'package:flutter_app/ui/common/loading_view.dart';
import 'package:flutter_app/ui/directory/directory_grid.dart';
import 'package:flutter_app/ui/directory/directory_page_view_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:path/path.dart';

class DirectoryPage extends StatelessWidget {
  DirectoryPage(this.drive, this.path);

  final Drive drive;
  final String path;

  void _showDirectorySortingDialog(
      {@required BuildContext context,
      @required DirectorySorting currentSorting}) {
    showDialog<DirectorySorting>(
      context: context,
      barrierDismissible: true,
      builder: (context) => _buildSortDialogWidget(context, currentSorting),
    ).then<void>((DirectorySorting value) {
      if (value != null) {
        StoreProvider.of<AppState>(context).dispatch(
            SortDirectoryAction(drive: drive, path: path, sorting: value));
      }
    });
  }

  Widget _buildSortDialogWidget(
      BuildContext context, DirectorySorting currentSorting) {
    return new SimpleDialog(
      title: const Text('Sort order'),
      children: <Widget>[
        _buildSimpleDialogOption(
            context, DirectorySorting.byCreationTimeAsc, currentSorting),
        _buildSimpleDialogOption(
            context, DirectorySorting.byCreationTimeDesc, currentSorting),
        _buildSimpleDialogOption(
            context, DirectorySorting.byNameAsc, currentSorting),
        _buildSimpleDialogOption(
            context, DirectorySorting.byNameDesc, currentSorting)
      ],
    );
  }

  Widget _buildSimpleDialogOption(BuildContext context,
      DirectorySorting sorting, DirectorySorting selectedSorting) {
    return new SimpleDialogOption(
      child: RadioListTile(
        value: sorting,
        groupValue: selectedSorting,
        title: Text(sorting.toString()),
        isThreeLine: false,
        selected: true,
        onChanged: null,
      ),
      onPressed: () {
        Navigator.pop(context, sorting);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DirectoryPageViewModel>(
        distinct: true,
        converter: (store) =>
            DirectoryPageViewModel.fromStore(store, drive, path),
        builder: (_, viewModel) => new Scaffold(
            appBar: AppBar(
              title: Text(basename(path)),
              centerTitle: Platform.isIOS,
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.sort,
                      color: Colors.white,
                    ),
                    onPressed: () => _showDirectorySortingDialog(
                        context: context, currentSorting: viewModel.sorting))
              ],
            ),
            body: DirectoryPageContent(viewModel)));
  }
}

class DirectoryPageContent extends StatelessWidget {
  DirectoryPageContent(this.viewModel);

  final DirectoryPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      status: viewModel.status,
      loadingContent: Text("Loading..."),
      errorContent: ErrorView(
        description: 'Could not load directory.',
        onRetry: viewModel.refreshDirectory,
      ),
      successContent: DirectoryGrid(
        drive: viewModel.drive,
        path: viewModel.path,
        content: viewModel.content,
        refreshCallback: viewModel.refreshDirectory,
        downloadFileCallback: viewModel.downloadFile,
      ),
    );
  }
}
