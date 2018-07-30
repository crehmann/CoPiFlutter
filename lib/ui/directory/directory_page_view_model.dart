import 'package:collection/collection.dart';
import 'package:flutter_app/models/directory_content.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/models/file.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/directory/directory_actions.dart';
import 'package:flutter_app/redux/directory/directory_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class DirectoryPageViewModel {
  DirectoryPageViewModel({
    @required this.status,
    @required this.drive,
    @required this.path,
    @required this.content,
    @required this.refreshDirectory,
    @required this.downloadFile,
  });

  final LoadingStatus status;
  final Drive drive;
  final String path;
  final List<DirectoryContent> content;
  final Function refreshDirectory;
  final Function(File) downloadFile;

  static DirectoryPageViewModel fromStore(
    Store<AppState> store,
    Drive drive,
    String path,
  ) {
    var directoryState =
        store.state.directoriesState[drive.device + ":" + path];
    if (directoryState == null) {
      directoryState = DirectoryState.initial();
      store.dispatch(RefreshDirectoryAction(drive: drive, path: path));
    }
    return DirectoryPageViewModel(
        status: directoryState.loadingStatus,
        drive: drive,
        path: path,
        content: directoryState.content,
        refreshDirectory: () =>
            store.dispatch(RefreshDirectoryAction(drive: drive, path: path)),
        downloadFile: (file) => store.dispatch(DownloadFileAction(file: file)));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DirectoryPageViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          const IterableEquality().equals(content, other.content);

  @override
  int get hashCode => status.hashCode ^ const IterableEquality().hash(content);
}
