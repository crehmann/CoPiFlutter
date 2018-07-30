import 'package:flutter_app/models/directory_content.dart';
import 'package:meta/meta.dart';
import 'package:optional/optional.dart';

@immutable
class File extends DirectoryContent {
  final int size;
  final String downloadLink;
  final Optional<String> previewLink;

  File({String name, DateTime creationTime, DateTime lastModified, this.size, this.downloadLink, this.previewLink})
      : super(name, false, creationTime, lastModified);
}
