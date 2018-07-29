import 'package:flutter/material.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/ui/common/info_message_view.dart';
import 'package:flutter_app/ui/directory/directory_page.dart';
import 'package:flutter_app/utils/formatter.dart';
import 'package:meta/meta.dart';

class DriveList extends StatelessWidget {
  static const Key emptyViewKey = const Key('emptyView');
  static const Key contentKey = const Key('content');

  DriveList({
    @required this.drives,
    @required this.onReloadCallback,
  });

  final List<Drive> drives;
  final VoidCallback onReloadCallback;

  void _browseDrive(BuildContext context, Drive drive) {
    Navigator.push<Null>(
      context,
      MaterialPageRoute(
        builder: (_) => DirectoryPage(drive, "/"),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
            leading: Icon(Icons.sd_card),
            title: Text(drives[index].description),
            subtitle: Text(formatBytes(drives[index].size, 2)),
            onTap: () {
              _browseDrive(context, drives[index]);
            });
      },
      itemCount: drives.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (drives.isEmpty) {
      return InfoMessageView(
        key: emptyViewKey,
        title: 'All empty!',
        description: 'Didn\'t find any drives at\nall. ¯\\_(ツ)_/¯',
        onActionButtonTapped: onReloadCallback,
      );
    }

    return _buildContent(context);
  }
}
