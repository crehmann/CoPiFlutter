import 'package:flutter_app/models/directory_content.dart';

enum SortKey { Name, CreationTime }

enum SortOrder { Asc, Desc }

class DirectorySorting {
  static const DirectorySorting byNameAsc =
      DirectorySorting._internal(SortKey.Name, SortOrder.Asc);
  static const DirectorySorting byNameDesc =
      DirectorySorting._internal(SortKey.Name, SortOrder.Desc);
  static const DirectorySorting byCreationTimeAsc =
      DirectorySorting._internal(SortKey.CreationTime, SortOrder.Asc);
  static const DirectorySorting byCreationTimeDesc =
      DirectorySorting._internal(SortKey.CreationTime, SortOrder.Desc);

  final SortKey sortKey;
  final SortOrder sortOrder;

  const DirectorySorting._internal(this.sortKey, this.sortOrder);

  int compare(DirectoryContent c1, DirectoryContent c2) {
    if (sortKey == SortKey.Name) {
      return sortOrder == SortOrder.Asc
          ? _compareByName(c1, c2)
          : _compareByName(c2, c1);
    }

    if (sortKey == SortKey.CreationTime) {
      return sortOrder == SortOrder.Asc
          ? _compareByCreationTime(c1, c2)
          : _compareByCreationTime(c2, c1);
    }

    return 0;
  }

  static int _compareByName(DirectoryContent c1, DirectoryContent c2) {
    return c1.name.compareTo(c2.name);
  }

  static int _compareByCreationTime(DirectoryContent c1, DirectoryContent c2) {
    return c1.creationTime.compareTo(c2.creationTime);
  }

  @override
  String toString() {
    var key = sortKey == SortKey.CreationTime ? "Creation Time" : "Name";
    var order = sortOrder == SortOrder.Asc ? "asc" : "desc";
    return "$key ($order)";
  }
}
