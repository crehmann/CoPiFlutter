import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/drive/drive_actions.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class DrivesPageViewModel {
  DrivesPageViewModel({
    @required this.status,
    @required this.drives,
    @required this.refreshDrives,
  });

  final LoadingStatus status;
  final List<Drive> drives;
  final Function refreshDrives;

  static DrivesPageViewModel fromStore(
    Store<AppState> store,
  ) {
    return DrivesPageViewModel(
      status: store.state.driveState.loadingStatus,
      drives: store.state.driveState.drives,
      refreshDrives: () => store.dispatch(RefreshDrivesAction()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrivesPageViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          const IterableEquality().equals(drives, other.drives);

  @override
  int get hashCode => status.hashCode ^ const IterableEquality().hash(drives);
}
