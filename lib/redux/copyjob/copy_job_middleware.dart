import 'dart:async';

import 'package:flutter_app/networking/copy_job_api.dart';
import 'package:flutter_app/redux/copyjob/copy_job_actions.dart';
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
    if (action is RefreshCopyJobListAction) {
      next(RequestingCopyJobListAction());

      try {
        var copyJobs = await api.fetchCopyJobs();
        next(ReceivedCopyJobListAction(copyJobs: copyJobs));
      } catch (e) {
        next(ErrorLoadingCopyJobListAction());
      } finally {
        action.completer.complete();
      }
    }
  }

  Future _handleRefreshCopyJobAction(action, NextDispatcher next) async {
    if (action is RefreshCopyJobAction) {
      try {
        var copyJob = await api.fetchCopyJob(action.id);
        next(ReceivedCopyJobAction(copyJob: copyJob));
      } catch (e) {
        next(ErrorLoadingCopyJobAction(id: action.id));
      } finally {
        action.completer.complete();
      }
    }
  }

  Future _handleCreateCopyJobAction(action, NextDispatcher next) async {
    if (action is CreateCopyJobAction) {
      try {
        next(CreatingCopyJobAction());
        var copyJob = await api.createCopyJob(action.sourceDevicePath,
            action.destinationDevicePath, action.flags, action.options);
        next(CreatedCopyJobAction(copyJob: copyJob));
        action.completer.complete();
      } catch (e) {
        next(ErrorCreatingCopyJobAction());
        action.completer.completeError(e);
      }
    }
  }
}
