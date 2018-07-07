import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Drive {
  final String device;
  final String devicePath;
  final String description;
  final int size;
  final bool isReadOnly;
  final bool isSystem;

  factory Drive.fromJson(Map<String, dynamic> json) {
    return Drive(
        device: json['device'] as String,
        devicePath: json['devicePath'] as String,
        description: json['description'] as String,
        size: json['size'] as int,
        isReadOnly: json['isReadOnly'] as bool,
        isSystem: json['isSystem'] as bool);
  }

  Drive(
      {this.device,
      this.devicePath,
      this.description,
      this.size,
      this.isReadOnly,
      this.isSystem});
}

Future<List<Drive>> fetchDrives(http.Client client) async {
  final response = await client.get('http://192.168.1.165:3000/drives');

  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseDrive, response.body);
}

// A function that will convert a response body into a List<Photo>
List<Drive> parseDrive(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Drive>((json) => Drive.fromJson(json)).toList();
}
