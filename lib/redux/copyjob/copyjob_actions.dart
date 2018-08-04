import 'dart:async';

import 'package:flutter_app/models/copy_job.dart';
import 'package:meta/meta.dart';

class RefreshCopyJobsAction {
  final Completer<Null> completer = new Completer();
}

class RefreshCopyJobAction {
  final Completer<Null> completer = new Completer();
  final String id;

  RefreshCopyJobAction({@required this.id});
}

class RequestingCopyJobsAction {}

class ErrorLoadingCopyJobsAction {}

class ReceivedCopyJobsAction {
  final List<CopyJob> copyJobs;

  ReceivedCopyJobsAction({@required this.copyJobs});
}

class ReceivedCopyJobAction {
  final CopyJob copyJob;

  ReceivedCopyJobAction({@required this.copyJob});
}

class ErrorLoadingCopyJobAction {}

class CreateCopyJobAction {
  final String sourceDevicePath;
  final String destinationDevicePath;
  final List<String> flags;
  final List<String> options;

  CreateCopyJobAction(
      {@required this.sourceDevicePath,
      @required this.destinationDevicePath,
      @required this.flags,
      @required this.options});
}

class CopyJobCreatingAction {}

class CopyJobCreatedAction {
  final CopyJob copyJob;

  CopyJobCreatedAction({@required this.copyJob});
}

class ErrorCreatingCopyJobAction {}
