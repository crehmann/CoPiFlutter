import 'package:built_collection/built_collection.dart';
import 'package:flutter_app/models/copy_job_state.dart';
import 'package:meta/meta.dart';

@immutable
class CopyJob {
  final String id;
  final String source;
  final String destination;
  final BuiltList<String> flags;
  final BuiltList<String> options;
  final String command;
  final int progress;
  final CopyJobStatus status;
  final BuiltList<String> output;
  final String error;

  CopyJob(
      {this.id,
      this.source,
      this.destination,
      this.flags,
      this.options,
      this.command,
      this.progress,
      this.status,
      this.output,
      this.error});

  CopyJob copyWith({int progress, CopyJobStatus status}) {
    return CopyJob(
        id: this.id,
        source: this.source,
        destination: this.destination,
        flags: this.flags,
        options: this.options,
        command: this.command,
        progress: progress ?? this.progress,
        status: status ?? this.status,
        output: this.output,
        error: this.error);
  }
}
