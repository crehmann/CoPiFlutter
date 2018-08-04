import 'dart:async';

import 'package:flutter_app/networking/copy_job_api.dart';
import 'package:flutter_app/redux/copyjob/copyjob_actions.dart';
import 'package:redux/redux.dart';

class CopyJobMiddleware extends MiddlewareClass {
  CopyJobMiddleware(this.api);

  final CopyJobApi api;

  @override
  void call(Store store, action, NextDispatcher next) async {
    next(action);
    await _handleRefreshCopyJobsAction(action, next);
    await _handleRefreshCopyJobAction(action, next);
    await _handleCreateCopyJobAction(action, next);
  }

  Future _handleRefreshCopyJobsAction(action, NextDispatcher next) async {
    if (action is RefreshCopyJobsAction) {
      next(RequestingCopyJobsAction());

      try {
        var copyJobs = await api.fetchCopyJobs();
        next(ReceivedCopyJobsAction(copyJobs: copyJobs));
        action.completer.complete();
      } catch (e) {
        next(ErrorLoadingCopyJobsAction());
        action.completer.complete();
      }
    }
  }

  Future _handleRefreshCopyJobAction(action, NextDispatcher next) async {
    if (action is RefreshCopyJobAction) {
      try {
        var copyJob = await api.fetchCopyJob(action.id);
        next(ReceivedCopyJobAction(copyJob: copyJob));
        action.completer.complete();
      } catch (e) {
        next(ErrorLoadingCopyJobAction());
        action.completer.complete();
      }
    }
  }

  Future _handleCreateCopyJobAction(action, NextDispatcher next) async {
    if (action is CreateCopyJobAction) {
      try {
        var copyJob = await api.createCopyJob(action.sourceDevicePath,
            action.destinationDevicePath, action.flags, action.options);
        next(CopyJobCreatedAction(copyJob: copyJob));
      } catch (e) {
        next(ErrorCreatingCopyJobAction());
      }
    }
  }
}
