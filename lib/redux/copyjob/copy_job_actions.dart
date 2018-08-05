import 'dart:async';

import 'package:flutter_app/models/copy_job.dart';
import 'package:meta/meta.dart';

// -- CopyJob List -- //

class RefreshCopyJobListAction {
  final Completer<Null> completer = new Completer();
}

class RequestingCopyJobListAction {}

class ErrorLoadingCopyJobListAction {}

class ReceivedCopyJobListAction {
  final List<CopyJob> copyJobs;

  ReceivedCopyJobListAction({@required this.copyJobs});
}

// -- Single CopyJob -- //

class RefreshCopyJobAction {
  final Completer<Null> completer = new Completer();
  final String id;

  RefreshCopyJobAction({@required this.id});
}

class RequestingCopyJobAction {
  final String id;

  RequestingCopyJobAction({@required this.id});
}

class ErrorLoadingCopyJobAction {
  final String id;

  ErrorLoadingCopyJobAction({@required this.id});
}

class ReceivedCopyJobAction {
  final CopyJob copyJob;

  ReceivedCopyJobAction({@required this.copyJob});
}

// -- Create CopyJob -- //

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

class CreatingCopyJobAction {}

class CreatedCopyJobAction {
  final CopyJob copyJob;

  CreatedCopyJobAction({@required this.copyJob});
}

class ErrorCreatingCopyJobAction {}
