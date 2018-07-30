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

class DirectoryGrid extends StatelessWidget {
  static const Key emptyViewKey = const Key('emptyView');
  static const Key contentKey = const Key('content');

  DirectoryGrid({
    @required this.drive,
    @required this.path,
    @required this.content,
    @required this.onReloadCallback,
    @required this.downloadFileCallback,
  });

  final Drive drive;
  final String path;
  final List<DirectoryContent> content;
  final VoidCallback onReloadCallback;
  final Function(File) downloadFileCallback;

  Widget _buildContent(BuildContext context) {
    return Container(
      key: contentKey,
      child: Scrollbar(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1,
          ),
          itemCount: content.length,
          itemBuilder: (BuildContext context, int index) {
            var contentItem = content[index];
            if (contentItem is Folder) {
              return DirectoryGridFolderItem(
                  item: contentItem,
                  onTapped: () => Navigator.push<Null>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DirectoryPage(drive, join(path, contentItem.name)),
                        ),
                      ));
            }
            if (contentItem is File) {
              return DirectoryGridFileItem(
                item: contentItem,
                onTapped: () => downloadFileCallback(contentItem),
              );
            }

            return Icon(Icons.error);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) {
      return InfoMessageView(
        key: emptyViewKey,
        title: 'All empty!',
        description: '',
        onActionButtonTapped: onReloadCallback,
      );
    }

    return _buildContent(context);
  }
}
