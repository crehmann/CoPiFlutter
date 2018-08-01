import 'package:built_collection/built_collection.dart';
import 'package:flutter_app/models/directory_content.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:flutter_app/redux/directory/directory_sorting.dart';
import 'package:meta/meta.dart';

@immutable
class DirectoryState {
  static const DirectorySorting defaultSorting =
      DirectorySorting.byCreationTimeDesc;

  DirectoryState._internal(
      {@required this.loadingStatus,
      @required this.content,
      this.soring = defaultSorting});

  final LoadingStatus loadingStatus;
  final BuiltList<DirectoryContent> content;
  final DirectorySorting soring;

  factory DirectoryState.initial() {
    return DirectoryState._internal(
      loadingStatus: LoadingStatus.loading,
      content: BuiltList(),
    );
  }

  DirectoryState copyWith({
    LoadingStatus loadingStatus,
    BuiltList<DirectoryContent> content,
  }) {
    return DirectoryState._internal(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      content: content == null ? this.content : _sort(content, this.soring),
    );
  }

  DirectoryState sortBy({
    @required DirectorySorting sorting,
  }) {
    return DirectoryState._internal(
        loadingStatus: this.loadingStatus,
        content: _sort(this.content, sorting),
        soring: sorting);
  }

  static BuiltList<DirectoryContent> _sort(
      BuiltList<DirectoryContent> content, DirectorySorting sorting) {
    var builder = content.toBuilder();
    builder.sort(sorting.compare);
    return builder.build();
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
