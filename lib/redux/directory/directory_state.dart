import 'package:flutter_app/models/directory_content.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:meta/meta.dart';

@immutable
class DirectoryState {
  DirectoryState({
    @required this.loadingStatus,
    @required this.content,
  });

  final LoadingStatus loadingStatus;
  final List<DirectoryContent> content;

  factory DirectoryState.initial() {
    return DirectoryState(
      loadingStatus: LoadingStatus.loading,
      content: <DirectoryContent>[],
    );
  }

  DirectoryState copyWith({
    LoadingStatus loadingStatus,
    List<DirectoryContent> content,
  }) {
    return DirectoryState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      content: content ?? this.content,
    );
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DirectoryState &&
          runtimeType == other.runtimeType &&
          loadingStatus == other.loadingStatus &&
          content == other.content;

  @override
  int get hashCode => loadingStatus.hashCode ^ content.hashCode;
}
