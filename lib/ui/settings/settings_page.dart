import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/copyjob/copy_job_actions.dart';
import 'package:flutter_app/redux/drive/drive_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_app/globals.dart' as globals;

class SettingsPage extends StatefulWidget {
  SettingsPage();

  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  TextEditingController _controller = new TextEditingController();

  Future<Null> _save(BuildContext context) async {
    await globals.setHost(_controller.text);
    final Store<AppState> state = StoreProvider.of<AppState>(context);
    state.dispatch(RefreshDrivesAction());
    state.dispatch(RefreshCopyJobListAction());
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _controller.text = globals.getHost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: Platform.isIOS,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
                controller: _controller,
                decoration: InputDecoration(hintText: 'Host')),
            SizedBox(height: 16.0),
            ButtonTheme(
              minWidth: double.infinity,
              child: RaisedButton(
                  onPressed: () {
                    _save(context);
                  },
                  child: Text('Save')),
            ),
          ],
        ),
      ),
    );
  }
}
