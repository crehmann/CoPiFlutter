import 'package:flutter_app/redux/drive/drive_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  AppState({
    @required this.driveState,
  });

  final DriveState driveState;

  factory AppState.initial() {
    return AppState(
      driveState: DriveState.initial(),
    );
  }

  AppState copyWith({
    DriveState driveState,
  }) {
    return AppState(
      driveState: driveState ?? this.driveState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          driveState == other.driveState;

  @override
  int get hashCode => driveState.hashCode;
}
