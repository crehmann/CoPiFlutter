import 'dart:async';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/networking/drive_parser.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/globals.dart' as globals;

class DriveApi {
  Future<List<Drive>> fetchDrives() async {
    final response = await getRequest(globals.getBaseUri().replace(path: 'drives'));
    return compute(DriveParser.parseJson, response);
  }
}
