import 'package:meta/meta.dart';

@immutable
abstract class DirectoryContent {
  final String name;
  final bool isDirectory;
  final DateTime birthtime;
  final DateTime mtimeMs;

  DirectoryContent(this.name, this.isDirectory, this.birthtime, this.mtimeMs);
}
