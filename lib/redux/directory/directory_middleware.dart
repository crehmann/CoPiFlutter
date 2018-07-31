import 'dart:async';

import 'package:flutter_app/models/directory_content.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/networking/directory_api.dart';
import 'package:flutter_app/redux/directory/directory_actions.dart';
import 'package:redux/redux.dart';

class DirectoryMiddleware extends MiddlewareClass {
  DirectoryMiddleware(this.api);

  final DirectoryApi api;

  @override
  void call(Store store, action, NextDispatcher next) async {
    next(action);
    if (action is RefreshDirectoryAction) {
      next(RequestingDirectoryAction.name(action.drive, action.path));

      try {
        var content = await _fetchDirectory(action.drive, action.path);
        next(ReceivedDirectoryAction(action.fullPath, content));
        action.completer.complete();
      } catch (e) {
        next(ErrorLoadingDirectoryAction.name(action.fullPath));
        action.completer.completeError(e);
      }
    }

    if (action is DownloadFileAction) {
      try {
        await api.downloadFile(action.file.downloadLink);
      } catch (e) {
        //TODO: show toast!
      }
    }
  }

  Future<List<DirectoryContent>> _fetchDirectory(
      Drive drive, String path) async {
    return await api.fetchDirectory(drive, path);
  }
}
