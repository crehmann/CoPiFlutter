import 'dart:async';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/networking/drive_parser.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter/foundation.dart';

class DriveApi {
  static final Uri driveBaseUri = new Uri.http('10.0.1.1:3000', 'drives');

  Future<List<Drive>> fetchDrives() async {
    final response = await getRequest(driveBaseUri);
    return compute(DriveParser.parseJson, response);
  }
}
