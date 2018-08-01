import 'dart:async';

import 'package:flutter_app/models/directory_content.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/models/file.dart';
import 'package:flutter_app/redux/directory/directory_sorting.dart';
import 'package:meta/meta.dart';

class RefreshDirectoryAction {
  final Completer<Null> completer = new Completer();
  final Drive drive;
  final String path;

  String get fullPath => drive.device + ":" + path;

  RefreshDirectoryAction({@required this.drive, @required this.path});
}

class RequestingDirectoryAction {
  final Drive drive;
  final String path;

  String get fullPath => drive.device + ":" + path;

  RequestingDirectoryAction.name(this.drive, this.path);
}

class ErrorLoadingDirectoryAction {
  final String fullPath;

  ErrorLoadingDirectoryAction.name(this.fullPath);
}

class SortDirectoryAction {
  final Drive drive;
  final String path;
  final DirectorySorting sorting;

  SortDirectoryAction({this.drive, this.path, this.sorting});

  String get fullPath => drive.device + ":" + path;
}

class ReceivedDirectoryAction {
  final String fullPath;
  final List<DirectoryContent> content;

  ReceivedDirectoryAction(this.fullPath, this.content);
}

class DownloadFileAction {
  final File file;

  DownloadFileAction({this.file});
}
