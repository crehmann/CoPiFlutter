import 'dart:async';

import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/networking/drive_api.dart';
import 'package:flutter_app/redux/drive/drive_actions.dart';
import 'package:redux/redux.dart';

class DriveMiddleware extends MiddlewareClass {
  DriveMiddleware(this.api);

  final DriveApi api;

  @override
  void call(Store store, action, NextDispatcher next) async {
    next(action);

    if (action is RefreshDrivesAction) {
      next(RequestingDrivesAction());

      try {
        var drives = await _fetchDrives(next);
        next(ReceivedDrivesAction(drives));
        action.completer.complete();
      } catch (e) {
        next(ErrorLoadingDrivesAction());
        action.completer.complete();
      }
    }
  }

  Future<List<Drive>> _fetchDrives(
    NextDispatcher next,
  ) async {
    return await api.fetchDrives();
  }
}
