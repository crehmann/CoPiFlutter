import 'dart:convert';

import 'package:flutter_app/models/directory.dart';
import 'package:flutter_app/models/directory_content.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/models/file.dart';

class DirectoryParser {
  static List<DirectoryContent> parseJson(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<Drive>((json) => json['isDirectory'] as bool
            ? Directory(
                name: json['name'] as String,
                birthtime: json['birthtime'] as int,
                mtimeMs: json['mtimeMs'] as int)
            : File(
                name: json['name'] as String,
                size: json['size'] as int,
                birthtime: json['birthtime'] as int,
                mtimeMs: json['mtimeMs'] as int))
        .toList();
  }
}
