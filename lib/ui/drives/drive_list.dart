import 'package:flutter/material.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/ui/common/info_message_view.dart';
import 'package:flutter_app/ui/drives/drives_list_tile.dart';
import 'package:meta/meta.dart';

class DriveList extends StatelessWidget {
  static const Key emptyViewKey = const Key('emptyView');
  static const Key contentKey = const Key('content');

  DriveList({
    @required this.drives,
    @required this.onReloadCallback,
  });

  final List<Drive> drives;
  final RefreshCallback onReloadCallback;

  @override
  Widget build(BuildContext context) {
    if (drives.isEmpty) {
      return InfoMessageView(
        key: emptyViewKey,
        title: 'All empty!',
        description: 'Didn\'t find any drives.',
        onActionButtonTapped: onReloadCallback,
      );
    }

    return RefreshIndicator(
      onRefresh: () => onReloadCallback(),
      child: Scrollbar(
        key: contentKey,
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 8.0),
          itemCount: drives.length,
          itemBuilder: (BuildContext context, int index) {
            return new DriveListTile(drives[index]);
          },
        ),
      ),
    );
  }
}
