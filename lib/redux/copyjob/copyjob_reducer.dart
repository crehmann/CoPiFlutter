import 'package:built_collection/built_collection.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:flutter_app/redux/copyjob/copyjob_actions.dart';
import 'package:flutter_app/redux/copyjob/copyjob_state.dart';
import 'package:redux/redux.dart';

final copyJobStateReducer = combineReducers<CopyJobState>([
  TypedReducer<CopyJobState, RequestingCopyJobsAction>(_requestingCopyJobs),
  TypedReducer<CopyJobState, ErrorLoadingCopyJobsAction>(_errorLoadingCopyJobs),
  TypedReducer<CopyJobState, ReceivedCopyJobsAction>(_receivedCopyJobs),

  TypedReducer<CopyJobState, ReceivedCopyJobAction>(_requestingCopyJob),
  TypedReducer<CopyJobState, ErrorLoadingCopyJobAction>(_errorLoadingCopyJob),
  TypedReducer<CopyJobState, CopyJobCreatedAction>(_receivedCopyJob),

  TypedReducer<CopyJobState, CopyJobCreatingAction>(_creatingCopyJob),
  TypedReducer<CopyJobState, ErrorCreatingCopyJobAction>(_requestingCopyJobs),
]);

CopyJobState _requestingCopyJobs(
    CopyJobState state, RequestingCopyJobsAction action) {
  return state.copyWith(copyJobsLoadingStatus: LoadingStatus.loading);
}

CopyJobState _errorLoadingCopyJobs(
    CopyJobState state, ErrorLoadingCopyJobsAction action) {
  return state.copyWith(copyJobsLoadingStatus: LoadingStatus.error);
}

CopyJobState _receivedCopyJobs(
    CopyJobState state, ReceivedCopyJobsAction action) {
  return state.copyWith(
      copyJobsLoadingStatus: LoadingStatus.success,
      copyJobs: BuiltList(action.copyJobs));
}
