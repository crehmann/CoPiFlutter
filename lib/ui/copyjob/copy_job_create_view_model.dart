import 'package:flutter/material.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class CopyJobCreatePageViewModel {
  CopyJobCreatePageViewModel({
    @required this.status,
    @required this.drives,
  });

  final LoadingStatus status;
  final List<Drive> drives;

  static CopyJobCreatePageViewModel fromStore(Store<AppState> store,) {
    return CopyJobCreatePageViewModel(
        status: store.state.copyJobState.createCopyJobLoadingStatus,
        drives: store.state.driveState.drives);
  }

}
