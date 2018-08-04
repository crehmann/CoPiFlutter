import 'dart:async';
import 'package:flutter_app/models/copy_job.dart';
import 'package:flutter_app/networking/copy_job_parser.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/globals.dart' as globals;

class CopyJobApi {
  Future<List<CopyJob>> fetchCopyJobs() async {
    final response =
        await getRequest(globals.baseUri.replace(path: 'copyjobs'));
    return compute(CopyJobParser.parseCopyJobListJson, response);
  }

  Future<CopyJob> fetchCopyJob(String id) async {
    final response =
        await getRequest(globals.baseUri.replace(path: 'copyjobs'));
    return compute(CopyJobParser.parseCopyJobJson, response);
  }

  Future<CopyJob> createCopyJob(
      String sourceDevicePath,
      String destinationDevicePath,
      List<String> flags,
      List<String> options) async {
    final response =
        await postRequest(globals.baseUri.replace(path: 'copyjobs'), {
      'source': sourceDevicePath,
      'destination': destinationDevicePath,
      'flags': flags,
      'options': options
    });
    return compute(CopyJobParser.parseCopyJobJson, response);
  }
}
