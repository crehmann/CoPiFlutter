import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/networking/web_socket_client.dart';
import 'package:flutter_app/redux/copyjob/copy_job_actions.dart';
import 'package:flutter_app/redux/drive/drive_actions.dart';
import 'package:flutter_app/ui/main_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/store.dart';
import 'package:redux/redux.dart';
import 'package:flutter_app/globals.dart' as globals;

Future<Null> main() async {
  await globals.init();
  var store = createStore();
  var webSocketClient = new WebSocketClient(store);
  webSocketClient.connect();
  runApp(CoPiApp(store));
}

class CoPiApp extends StatefulWidget {
  final Store<AppState> store;

  CoPiApp(this.store);

  @override
  _CoPiAppState createState() => _CoPiAppState();
}

class _CoPiAppState extends State<CoPiApp> {
  @override
  void initState() {
    super.initState();
    widget.store.dispatch(RefreshDrivesAction());
    widget.store.dispatch(RefreshCopyJobListAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: 'CoPi',
        theme: ThemeData(
          primaryColor: const Color(0xFF1C306D),
          accentColor: const Color(0xFFFFAD32),
          primaryIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: const Color(0xFF1C306D)),
        ),
        home: const MainPage(),
      ),
    );
  }
}
