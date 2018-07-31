import 'dart:async';

import 'package:flutter_app/models/drive.dart';

class RefreshDrivesAction {
  final Completer completer = new Completer();
}

class RequestingDrivesAction {}

class ErrorLoadingDrivesAction {}

class ReceivedDrivesAction {
  final List<Drive> drives;

  ReceivedDrivesAction(this.drives);

  @override
  String toString() {
    return 'ReceivedDrivesAction{drives: $drives}';
  }
}
