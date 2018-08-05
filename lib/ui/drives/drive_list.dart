import 'package:flutter/cupertino.dart' as cupertino;
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
  final RefreshCallback onReloadCallback;

  void _browseDrive(BuildContext context, Drive drive) {
    Navigator.of(context).push(new cupertino.CupertinoPageRoute<Null>(
      builder: (BuildContext context) {
        return new DirectoryPage(drive, "/");
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (drives.isEmpty) {
      return SliverFillRemaining(
          child: InfoMessageView(
        key: emptyViewKey,
        title: 'All empty!',
        description: 'Didn\'t find any drives.',
        onActionButtonTapped: null,
      ));
    }

    return RefreshIndicator(
      onRefresh: () => onReloadCallback(),
      child: Scrollbar(
        key: contentKey,
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 8.0),
          itemCount: drives.length,
          itemBuilder: (BuildContext context, int index) {
            return Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: () => _browseDrive(context, drives[index]),
                    child: new Container(
                        color: cupertino.CupertinoColors.white,
                        padding: const EdgeInsets.only(left: 16.0, top: 9.0),
                        child: new Container(
                          padding: const EdgeInsets.only(bottom: 9.0),
                          decoration: const BoxDecoration(
                            border: const Border(
                              bottom: const BorderSide(
                                  color: const Color(0xFFBCBBC1), width: 0.0),
                            ),
                          ),
                          child: new Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 9.0),
                                child: Icon(Icons.sd_card),
                              ),
                              new Expanded(
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      drives[index].description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    new Text(
                                      formatBytes(drives[index].size, 2),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        color: cupertino
                                            .CupertinoColors.inactiveGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))));
          },
        ),
      ),
    );
  }
}
