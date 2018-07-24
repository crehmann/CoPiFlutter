import 'dart:async';

import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/app/app_reducer.dart';
import 'package:flutter_app/networking/drive_api.dart';
import 'package:flutter_app/redux/drive/drive_middleware.dart';
import 'package:redux/redux.dart';

Future<Store<AppState>> createStore() async {
  var driveApi = DriveApi();

  return Store(
    appReducer,
    initialState: AppState.initial(),
    distinct: true,
    middleware: [
      DriveMiddleware(driveApi),
    ],
  );
}
