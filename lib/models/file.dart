import 'package:flutter_app/models/directory_content.dart';
import 'package:meta/meta.dart';

@immutable
class File extends DirectoryContent {
  final int size;

  File({String name, this.size, DateTime birthtime, DateTime mtimeMs})
      : super(name, false, birthtime, mtimeMs);
}