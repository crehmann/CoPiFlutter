import 'package:flutter_app/models/directory_content.dart';
import 'package:meta/meta.dart';

@immutable
class Directory extends DirectoryContent {
  Directory(String name, int birthtime, int mtimeMs)
      : super(name, true, birthtime, mtimeMs);
}
