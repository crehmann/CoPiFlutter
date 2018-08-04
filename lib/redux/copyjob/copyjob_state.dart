import 'package:built_collection/built_collection.dart';
import 'package:flutter_app/models/copy_job.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:meta/meta.dart';

@immutable
class CopyJobState {
  CopyJobState({
    @required this.createCopyJobLoadingStatus,
    @required this.copyJobsLoadingStatus,
    @required this.copyJobs,
  });

  final LoadingStatus createCopyJobLoadingStatus;
  final LoadingStatus copyJobsLoadingStatus;
  final BuiltList<CopyJob> copyJobs;

  factory CopyJobState.initial() {
    return CopyJobState(
      createCopyJobLoadingStatus: LoadingStatus.success,
      copyJobsLoadingStatus: LoadingStatus.success,
      copyJobs: BuiltList(),
    );
  }

  CopyJobState copyWith(
      {LoadingStatus createCopyJobLoadingStatus,
      LoadingStatus copyJobsLoadingStatus,
      BuiltList<CopyJob> copyJobs}) {
    return CopyJobState(
      createCopyJobLoadingStatus:
          createCopyJobLoadingStatus ?? this.createCopyJobLoadingStatus,
      copyJobsLoadingStatus:
          copyJobsLoadingStatus ?? this.copyJobsLoadingStatus,
      copyJobs: copyJobs ?? this.copyJobs,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CopyJobState &&
          runtimeType == other.runtimeType &&
          createCopyJobLoadingStatus == other.createCopyJobLoadingStatus &&
          copyJobsLoadingStatus == other.copyJobsLoadingStatus &&
          copyJobs == other.copyJobs;

  @override
  int get hashCode =>
      createCopyJobLoadingStatus.hashCode ^
      copyJobsLoadingStatus.hashCode ^
      copyJobs.hashCode;
}
