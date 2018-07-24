import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:meta/meta.dart';

@immutable
class DriveState {
  DriveState({
    @required this.loadingStatus,
    @required this.drives,
  });

  final LoadingStatus loadingStatus;
  final List<Drive> drives;

  factory DriveState.initial() {
    return DriveState(
      loadingStatus: LoadingStatus.loading,
      drives: <Drive>[],
    );
  }

  DriveState copyWith({
    LoadingStatus loadingStatus,
    List<Drive> drives,
  }) {
    return DriveState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      drives: drives ?? this.drives,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriveState &&
          runtimeType == other.runtimeType &&
          loadingStatus == other.loadingStatus &&
          drives == other.drives;

  @override
  int get hashCode => loadingStatus.hashCode ^ drives.hashCode;
}
