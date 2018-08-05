import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/copyjob/copy_job_actions.dart';
import 'package:flutter_app/redux/drive/drive_actions.dart';
import 'package:flutter_app/ui/main_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/common_actions.dart';
import 'package:flutter_app/redux/store.dart';
import 'package:redux/redux.dart';

Future<Null> main() async {
  // ignore: deprecated_member_use
  MaterialPageRoute.debugEnableFadingRoutes = true;
  runApp(CoPiApp());
}

class CoPiApp extends StatelessWidget {
  final Store<AppState> store = createStore();

  CoPiApp() {
    store.dispatch(RefreshCopyJobListAction());
    store.dispatch(RefreshDrivesAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
          title: 'CoPi',
          debugShowCheckedModeBanner: false,
          home: const MainPage()),
    );
  }
}
