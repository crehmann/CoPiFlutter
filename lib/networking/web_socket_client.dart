import 'dart:convert';
import 'package:flutter_app/networking/copy_job_parser.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/copyjob/copy_job_actions.dart';
import 'package:redux/redux.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_app/globals.dart' as globals;

class WebSocketClient {
  final Store<AppState> store;

  WebSocketClient(this.store);

  void connect() {
    IOWebSocketChannel
        .connect('ws://${globals.getHost()}')
        .stream
        .listen((msg) {
      final parsed = json.decode(msg);
      print(parsed);
      if (parsed["subject"] == "copyJobProgress") {
        var id = parsed["data"]["id"] as String;
        var progress = parsed["data"]["progress"] as int;
        var status = CopyJobParser.parseCopyJobState(
            parsed["data"]["state"] as String);
        store.dispatch(
            CopyJobProgressUpdatedAction(id: id, progress: progress, status: status));
      }
    });
  }
}
