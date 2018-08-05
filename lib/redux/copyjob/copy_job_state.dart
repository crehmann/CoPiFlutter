import 'package:flutter_app/models/copy_job.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:meta/meta.dart';

@immutable
class CopyJobState {
  CopyJobState({
    @required this.loadingStatus,
    @required this.copyJob,
  });

  final LoadingStatus loadingStatus;
  final CopyJob copyJob;


  CopyJobState copyWith({LoadingStatus loadingStatus,
    CopyJob copyJob}) {
    return CopyJobState(
      loadingStatus:
      loadingStatus ?? this.loadingStatus,
      copyJob:
      copyJob ?? this.copyJob,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CopyJobState &&
              runtimeType == other.runtimeType &&
              loadingStatus == other.loadingStatus &&
              copyJob == other.copyJob;

  @override
  int get hashCode =>
      loadingStatus.hashCode ^
      copyJob.hashCode;
}