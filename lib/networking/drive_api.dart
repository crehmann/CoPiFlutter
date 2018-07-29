import 'dart:async';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/networking/drive_parser.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/globals.dart' as globals;

class DriveApi {
  static final Uri driveBaseUri = new Uri.http(globals.baseUrl, 'drives');

  Future<List<Drive>> fetchDrives() async {
    final response = await getRequest(driveBaseUri);
    return compute(DriveParser.parseJson, response);
  }
}
