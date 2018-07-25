import 'dart:collection';

import 'package:flutter_app/models/directory_content.dart';
import 'package:flutter_app/redux/directory/directory_state.dart';
import 'package:flutter_app/redux/drive/drive_state.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  AppState({
    @required this.driveState,
    @required this.directoriesState,
  });

  final DriveState driveState;
  final BuiltMap<String, DirectoryState> directoriesState;

  factory AppState.initial() {
    return AppState(
      driveState: DriveState.initial(),
      directoriesState: new BuiltMap<String, DirectoryState>(),
    );
  }

  AppState copyWith({
    DriveState driveState,
    HashMap<String, DirectoryContent> directoriesState,
  }) {
    return AppState(
        driveState: driveState ?? this.driveState,
        directoriesState: directoriesState ?? this.directoriesState);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          driveState == other.driveState &&
          directoriesState == other.directoriesState;

  @override
  int get hashCode => driveState.hashCode ^ directoriesState.hashCode;
}
