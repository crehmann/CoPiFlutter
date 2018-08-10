import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

String _host = "10.0.1.1:3000";

Future<Null> init() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  _host = prefs.getString("host") ?? "10.0.1.1:3000";
}

Future<Null> setHost(String host) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("host", host);
  _host = host;
}

String getHost() => _host;

Uri getBaseUri() {
  return Uri.http(_host, "");
}
