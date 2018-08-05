import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_app/models/copy_job.dart';
import 'package:flutter_app/models/copy_job_state.dart';

class CopyJobParser {
  static List<CopyJob> parseCopyJobListJson(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<CopyJob>((json) => parseCopyJobJson(json)).toList();
  }

  static CopyJob parseCopyJobJson(dynamic json) {
    return CopyJob(
        id: json['id'] as String,
        source: json['source'] as String,
        destination: json['destination'] as String,
        flags: BuiltList(
            (json['flags'] as List).map<String>((d) => d as String)),
        options: BuiltList(
            (json['options'] as List).map<String>((d) => d as String)),
        command: json['command'] as String,
        progress: json['progress'] as int,
        status: _parseCopyJobState(json['state'] as String),
        output: BuiltList(
            (json['output'] as List).map<String>((d) => d as String)),
        error: json['error'] as String);
  }

  static CopyJobStatus _parseCopyJobState(String value) {
    switch (value) {
      case "inProgress":
        return CopyJobStatus.InProgress;
      case "completed":
        return CopyJobStatus.Completed;
      case "canceled":
        return CopyJobStatus.Canceled;
      case "failed":
        return CopyJobStatus.Failed;
      default:
        throw Exception("Unknown state: " + value);
    }
  }
}
