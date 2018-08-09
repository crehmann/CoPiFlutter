import 'package:flutter/material.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/ui/directory/directory_page.dart';
import 'package:flutter_app/utils/formatter.dart';

class DriveListTile extends StatelessWidget {
  DriveListTile(this.drive);

  final Drive drive;

  void _browseDrive(BuildContext context, Drive drive) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return new DirectoryPage(drive, "/");
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () => _browseDrive(context, drive),
            child: new Container(
                color: Colors.white,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(
                              drive.description + " (${drive.device})",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            new Text(
                              formatBytes(drive.size, 2),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}
