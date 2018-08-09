import 'dart:convert';

import 'package:flutter_app/models/folder.dart';
import 'package:flutter_app/models/directory_content.dart';
import 'package:flutter_app/models/file.dart';
import 'package:optional/optional.dart';

class DirectoryParser {
  static List<DirectoryContent> parseJson(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<DirectoryContent>((json) =>
    json['isDirectory'] as bool
        ? Folder(
        name: json['name'] as String,
        creationTime: DateTime.fromMillisecondsSinceEpoch(
            (json['birthtime'] as num).toInt(),
            isUtc: true),
        lastModified: DateTime.fromMillisecondsSinceEpoch(
            (json['mtimeMs'] as num).toInt(),
            isUtc: true))
        : File(
        name: json['name'] as String,
        creationTime: DateTime.fromMillisecondsSinceEpoch(
            (json['birthtimeMs'] as num).toInt(),
            isUtc: true),
        lastModified: DateTime.fromMillisecondsSinceEpoch(
            (json['mtimeMs'] as num).toInt(),
            isUtc: true),
        size: json['size'] as int,
        downloadLink: json['downloadLink'] as String,
        previewLink: json['previewLink'] == null ? Optional.empty()
            : Optional.of(json['previewLink'] as String)))
        .toList();
  }
}
