import 'package:flutter_app/networking/directory_api.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/app/app_reducer.dart';
import 'package:flutter_app/networking/drive_api.dart';
import 'package:flutter_app/networking/copy_job_api.dart';
import 'package:flutter_app/redux/copyjob/copy_job_middleware.dart';
import 'package:flutter_app/redux/directory/directory_middleware.dart';
import 'package:flutter_app/redux/drive/drive_middleware.dart';
import 'package:redux/redux.dart';

Store<AppState> createStore() {
  var driveApi = DriveApi();
  var directoryApi = DirectoryApi();
  var copyJobApi = CopyJobApi();

  return Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    distinct: true,
    middleware: [
      DriveMiddleware(driveApi),
      DirectoryMiddleware(directoryApi),
      CopyJobMiddleware(copyJobApi),
    ],
  );
}
