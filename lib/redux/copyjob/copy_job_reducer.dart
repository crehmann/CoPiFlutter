import 'package:built_collection/built_collection.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:flutter_app/redux/copyjob/copy_job_actions.dart';
import 'package:flutter_app/redux/copyjob/copy_job_list_state.dart';
import 'package:flutter_app/redux/copyjob/copy_job_state.dart';
import 'package:redux/redux.dart';

final copyJobStateReducer = combineReducers<CopyJobListState>([
  TypedReducer<CopyJobListState, RequestingCopyJobListAction>(
      _requestingCopyJobList),
  TypedReducer<CopyJobListState, ErrorLoadingCopyJobListAction>(
      _errorLoadingCopyJobList),
  TypedReducer<CopyJobListState, ReceivedCopyJobListAction>(
      _receivedCopyJobList),
  TypedReducer<CopyJobListState, RequestingCopyJobAction>(_requestingCopyJob),
  TypedReducer<CopyJobListState, ErrorLoadingCopyJobAction>(
      _errorLoadingCopyJob),
  TypedReducer<CopyJobListState, ReceivedCopyJobAction>(_receivedCopyJob),
  TypedReducer<CopyJobListState, CreatingCopyJobAction>(_creatingCopyJob),
  TypedReducer<CopyJobListState, CreatedCopyJobAction>(_createdCopyJob),
  TypedReducer<CopyJobListState, ErrorCreatingCopyJobAction>(
      _errorCreatingCopyJob),
  TypedReducer<CopyJobListState, CopyJobProgressUpdatedAction>(
      _updateCopyJobProgress),
]);

CopyJobListState _requestingCopyJobList(
    CopyJobListState state, RequestingCopyJobListAction action) {
  return state.copyWith(copyJobsLoadingStatus: LoadingStatus.loading);
}

CopyJobListState _errorLoadingCopyJobList(
    CopyJobListState state, ErrorLoadingCopyJobListAction action) {
  return state.copyWith(copyJobsLoadingStatus: LoadingStatus.error);
}

CopyJobListState _receivedCopyJobList(
    CopyJobListState state, ReceivedCopyJobListAction action) {
  return state.copyWith(
      copyJobsLoadingStatus: LoadingStatus.success,
      copyJobStates: BuiltList(action.copyJobs.map<CopyJobState>((c) =>
          CopyJobState(copyJob: c, loadingStatus: LoadingStatus.success))));
}

CopyJobListState _requestingCopyJob(
    CopyJobListState state, RequestingCopyJobAction action) {
  return state.copyAndUpdateCopyJobState(
      withId: action.id, loadingStatus: LoadingStatus.loading);
}

CopyJobListState _errorLoadingCopyJob(
    CopyJobListState state, ErrorLoadingCopyJobAction action) {
  return state.copyAndUpdateCopyJobState(
      withId: action.id, loadingStatus: LoadingStatus.error);
}

CopyJobListState _receivedCopyJob(
    CopyJobListState state, ReceivedCopyJobAction action) {
  return state.copyAndUpdateCopyJobState(
      withId: action.copyJob.id,
      loadingStatus: LoadingStatus.success,
      copyJob: action.copyJob);
}

CopyJobListState _creatingCopyJob(
    CopyJobListState state, CreatingCopyJobAction action) {
  return state.copyWith(createCopyJobLoadingStatus: LoadingStatus.loading);
}

CopyJobListState _createdCopyJob(
    CopyJobListState state, CreatedCopyJobAction action) {
  var builder = state.copyJobStates.toBuilder();
  builder.add(CopyJobState(
      loadingStatus: LoadingStatus.success, copyJob: action.copyJob));

  return state.copyWith(
      createCopyJobLoadingStatus: LoadingStatus.success,
      copyJobStates: builder.build());
}

CopyJobListState _errorCreatingCopyJob(
    CopyJobListState state, ErrorCreatingCopyJobAction action) {
  return state.copyWith(createCopyJobLoadingStatus: LoadingStatus.error);
}

CopyJobListState _updateCopyJobProgress(
    CopyJobListState state, CopyJobProgressUpdatedAction action) {
  var copyJobState = state.copyJobStates
      .firstWhere((s) => s.copyJob.id == action.id, orElse: () => null);
  if (copyJobState == null) return state;

  return state.copyAndUpdateCopyJobState(
      withId: action.id,
      copyJob: copyJobState.copyJob.copyWith(progress: action.progress, status: action.status));
}
