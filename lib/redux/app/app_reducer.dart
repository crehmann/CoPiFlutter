import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/drive/drive_reducer.dart';
import 'package:flutter_app/redux/directory/directory_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    driveState: driveReducer(state.driveState, action),
    directoriesState: directoryReducer(state.directoriesState, action),
  );
}
