import 'dart:convert';

import 'package:flutter_app/models/drive.dart';

class DriveParser {
  static List<Drive> parseJson(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<Drive>((json) => Drive(
            device: json['device'] as String,
            devicePath: json['devicePath'] as String,
            description: json['description'] as String,
            size: json['size'] as int,
            isReadOnly: json['isReadOnly'] as bool,
            isSystem: json['isSystem'] as bool))
        .toList();
  }
}
