import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/directory_content.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/models/file.dart';
import 'package:flutter_app/models/folder.dart';
import 'package:flutter_app/ui/common/info_message_view.dart';
import 'package:flutter_app/ui/directory/directory_grid_item_file.dart';
import 'package:flutter_app/ui/directory/directory_grid_item_folder.dart';
import 'package:flutter_app/ui/directory/directory_page.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

class DirectoryGridSliver extends StatelessWidget {
  static const Key emptyViewKey = const Key('emptyView');
  static const Key contentKey = const Key('content');

  DirectoryGridSliver({
    @required this.drive,
    @required this.path,
    @required this.content,
    @required this.downloadFileCallback,
  });

  final Drive drive;
  final String path;
  final BuiltList<DirectoryContent> content;
  final Function(File) downloadFileCallback;

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) {
      return SliverFillRemaining(
          child: Center(
              child: InfoMessageView(
        key: emptyViewKey,
        title: 'Empty',
        description: 'This directory is empty.',
      )));
    }

    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        var contentItem = content[index];
        if (contentItem is Folder) {
          return DirectoryGridFolderItem(
              item: contentItem,
              onTapped: () =>
                  _browseDrive(context, drive, join(path, contentItem.name)));
        }
        if (contentItem is File) {
          return DirectoryGridFileItem(
            item: contentItem,
            onTapped: () => downloadFileCallback(contentItem),
          );
        }

        return Icon(Icons.error);
      }, childCount: content.length),
    );
  }

  void _browseDrive(BuildContext context, Drive drive, String path) {
    Navigator.of(context).push(new CupertinoPageRoute<Null>(
      builder: (BuildContext context) {
        return new DirectoryPage(drive, path);
      },
    ));
  }
}
