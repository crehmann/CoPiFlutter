import 'dart:convert';

import 'package:flutter_app/models/folder.dart';
import 'package:flutter_app/models/directory_content.dart';
import 'package:flutter_app/models/file.dart';

class DirectoryParser {
  static List<DirectoryContent> parseJson(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<DirectoryContent>((json) => json['isDirectory'] as bool
            ? Folder(
                name: json['name'] as String,
                birthtime: DateTime.fromMicrosecondsSinceEpoch(
                    (json['birthtime'] as num).toInt(),
                    isUtc: true),
                mtimeMs: DateTime.fromMicrosecondsSinceEpoch(
                    (json['mtimeMs'] as num).toInt(),
                    isUtc: true))
            : File(
                name: json['name'] as String,
                size: json['size'] as int,
                birthtime: DateTime.fromMicrosecondsSinceEpoch(
                    (json['birthtime'] as num).toInt(),
                    isUtc: true),
                mtimeMs: DateTime.fromMicrosecondsSinceEpoch(
                    (json['mtimeMs'] as num).toInt(),
                    isUtc: true)))
        .toList();
  }
}
