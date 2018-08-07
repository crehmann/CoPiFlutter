import 'package:flutter/material.dart';
import 'package:flutter_app/models/copy_job.dart';
import 'package:flutter_app/ui/common/info_message_view.dart';
import 'package:flutter_app/ui/copyjob/copy_job_list_tile.dart';

class CopyJobList extends StatelessWidget {
  static const Key emptyViewKey = Key('emptyView');
  static const Key contentKey = Key('content');

  CopyJobList({this.copyJobs, this.onReloadCallback});

  final List<CopyJob> copyJobs;
  final RefreshCallback onReloadCallback;

  @override
  Widget build(BuildContext context) {
    if (copyJobs.isEmpty) {
      return InfoMessageView(
        key: emptyViewKey,
        title: 'No Copy Jobs',
        description: 'Create a new copy job!',
        onActionButtonTapped: () => onReloadCallback(),
      );
    }

    return RefreshIndicator(
      onRefresh: () => onReloadCallback(),
      child: Scrollbar(
        key: contentKey,
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 8.0),
          itemCount: copyJobs.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                CopyJobListTile(copyJob: copyJobs[index], clickable: true),
                const Divider(
                  height: 1.0,
                  color: const Color(0x40000000),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
