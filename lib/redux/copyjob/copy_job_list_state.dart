import 'package:built_collection/built_collection.dart';
import 'package:flutter_app/models/copy_job.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:flutter_app/redux/copyjob/copy_job_state.dart';
import 'package:meta/meta.dart';

@immutable
class CopyJobListState {
  CopyJobListState({
    @required this.createCopyJobLoadingStatus,
    @required this.copyJobListLoadingStatus,
    @required this.copyJobStates,
  });

  final LoadingStatus createCopyJobLoadingStatus;
  final LoadingStatus copyJobListLoadingStatus;
  final BuiltList<CopyJobState> copyJobStates;

  factory CopyJobListState.initial() {
    return CopyJobListState(
      createCopyJobLoadingStatus: LoadingStatus.success,
      copyJobListLoadingStatus: LoadingStatus.success,
      copyJobStates: BuiltList(),
    );
  }

  CopyJobListState copyWith(
      {LoadingStatus createCopyJobLoadingStatus,
      LoadingStatus copyJobsLoadingStatus,
      BuiltList<CopyJobState> copyJobStates}) {
    return CopyJobListState(
      createCopyJobLoadingStatus:
          createCopyJobLoadingStatus ?? this.createCopyJobLoadingStatus,
      copyJobListLoadingStatus:
          copyJobsLoadingStatus ?? this.copyJobListLoadingStatus,
      copyJobStates: copyJobStates ?? this.copyJobStates,
    );
  }

  CopyJobListState copyAndUpdateCopyJobState(
      {@required String withId,
      LoadingStatus loadingStatus,
      CopyJob copyJob}) {
    var copyJobState = copyJobStates
        .firstWhere((s) => s.copyJob.id == withId, orElse: null);

    if (copyJobState == null) return this;

    var builder = copyJobStates.toBuilder();
    builder[copyJobStates.indexOf(copyJobState)] =
        copyJobState.copyWith(loadingStatus: loadingStatus, copyJob: copyJob);

    return new CopyJobListState(
        createCopyJobLoadingStatus: this.createCopyJobLoadingStatus,
        copyJobListLoadingStatus: this.copyJobListLoadingStatus,
        copyJobStates: builder.build());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CopyJobListState &&
          runtimeType == other.runtimeType &&
          createCopyJobLoadingStatus == other.createCopyJobLoadingStatus &&
          copyJobListLoadingStatus == other.copyJobListLoadingStatus &&
          copyJobStates == other.copyJobStates;

  @override
  int get hashCode =>
      createCopyJobLoadingStatus.hashCode ^
      copyJobListLoadingStatus.hashCode ^
      copyJobStates.hashCode;
}
