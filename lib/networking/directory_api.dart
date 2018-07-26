import 'dart:async';
import 'package:flutter_app/models/directory_content.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/networking/directory_parser.dart';
import 'package:flutter_app/networking/drive_parser.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter/foundation.dart';

class DirectoryApi {
  Future<List<DirectoryContent>> fetchDirectory(
      Drive drive, String path) async {
    var directoryUri =
        new Uri.http('10.0.1.1:3000', 'drives/' + drive.device, {"path": path});
    final response = await getRequest(directoryUri);
    return compute(DirectoryParser.parseJson, response);
  }
}
