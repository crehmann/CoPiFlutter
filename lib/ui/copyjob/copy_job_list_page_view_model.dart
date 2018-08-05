import 'package:flutter/material.dart';
import 'package:flutter_app/models/copy_job.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/copyjob/copy_job_actions.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class CopyJobListPageViewModel {
  CopyJobListPageViewModel({
    @required this.status,
    @required this.copyJobs,
    @required this.refreshCopyJobs,
  });

  final LoadingStatus status;
  final List<CopyJob> copyJobs;
  final RefreshCallback refreshCopyJobs;

  static CopyJobListPageViewModel fromStore(
    Store<AppState> store,
  ) {
    return CopyJobListPageViewModel(
      status: store.state.copyJobState.copyJobListLoadingStatus,
      copyJobs: store.state.copyJobState.copyJobStates
          .map((s) => s.copyJob)
          .toList(growable: false),
      refreshCopyJobs: () {
        var action = RefreshCopyJobListAction();
        store.dispatch(action);
        return action.completer.future;
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CopyJobListPageViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          copyJobs == other.copyJobs &&
          refreshCopyJobs == other.refreshCopyJobs;

  @override
  int get hashCode =>
      status.hashCode ^ copyJobs.hashCode ^ refreshCopyJobs.hashCode;
}
