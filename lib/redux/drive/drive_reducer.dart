import 'package:flutter_app/models/loading_status.dart';
import 'package:flutter_app/redux/drive/drive_actions.dart';
import 'package:flutter_app/redux/drive/drive_state.dart';
import 'package:redux/redux.dart';

final driveReducer = combineReducers<DriveState>([
  TypedReducer<DriveState, RequestingDrivesAction>(_requestingDrives),
  TypedReducer<DriveState, ReceivedDrivesAction>(_receivedDrives),
  TypedReducer<DriveState, ErrorLoadingDrivesAction>(_errorLoadingDrives),
]);

DriveState _requestingDrives(DriveState state, RequestingDrivesAction action) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

DriveState _receivedDrives(DriveState state, ReceivedDrivesAction action) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    drives: action.drives,
  );
}

DriveState _errorLoadingDrives(
    DriveState state, ErrorLoadingDrivesAction action) {
  return state.copyWith(loadingStatus: LoadingStatus.error);
}
