import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/main_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/common_actions.dart';
import 'package:flutter_app/redux/store.dart';
import 'package:redux/redux.dart';

Future<Null> main() async {
  // ignore: deprecated_member_use
  MaterialPageRoute.debugEnableFadingRoutes = true;

  var store = await createStore();
  runApp(CoPiApp(store));
}

class CoPiApp extends StatefulWidget {
  CoPiApp(this.store);

  final Store<AppState> store;

  @override
  _CoPiAppState createState() => _CoPiAppState();
}

class _CoPiAppState extends State<CoPiApp> {
  @override
  void initState() {
    super.initState();
    widget.store.dispatch(InitAction());
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
        ),
        home: const MainPage(),
      ),
    );
  }
}
