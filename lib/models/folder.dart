import 'package:flutter_app/models/directory_content.dart';
import 'package:meta/meta.dart';

@immutable
class Folder extends DirectoryContent {
  Folder({String name, DateTime birthtime, DateTime mtimeMs})
      : super(name, true, birthtime, mtimeMs);
}
