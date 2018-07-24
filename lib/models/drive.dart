import 'package:meta/meta.dart';

@immutable
class Drive {
  final String device;
  final String devicePath;
  final String description;
  final int size;
  final bool isReadOnly;
  final bool isSystem;

  Drive(
      {this.device,
      this.devicePath,
      this.description,
      this.size,
      this.isReadOnly,
      this.isSystem});
}
