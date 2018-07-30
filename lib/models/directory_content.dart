import 'package:meta/meta.dart';

@immutable
abstract class DirectoryContent {
  final String name;
  final bool isDirectory;
  final DateTime creationTime;
  final DateTime lastModified;

  DirectoryContent(this.name, this.isDirectory, this.creationTime, this.lastModified);
}
