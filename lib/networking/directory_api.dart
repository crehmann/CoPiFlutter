import 'dart:async';
import 'package:flutter_app/models/directory_content.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/networking/directory_parser.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

class DirectoryApi {
  Future<List<DirectoryContent>> fetchDirectory(
      Drive drive, String path) async {
    var directoryUri = globals.baseUri.replace(
        path: 'drives/' + drive.devicePath, queryParameters: {"path": path});
    final response = await getRequest(directoryUri);
    return compute(DirectoryParser.parseJson, response);
  }

  Future downloadFile(String path) async {
    final downloadUri = globals.baseUri.toString() + path;

    if (await canLaunch(downloadUri)) {
      await launch(downloadUri);
    } else {
      throw 'Could not launch $downloadUri';
    }
  }
}
