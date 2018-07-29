import 'package:flutter/material.dart';
import 'package:flutter_app/models/folder.dart';
import 'package:flutter_app/models/directory_content.dart';
import 'package:flutter_app/models/file.dart';
import 'package:flutter_app/utils/formatter.dart';
import 'package:meta/meta.dart';
import 'package:flutter_app/ui/style.dart' as style;

class DirectoryGridFolderItem extends StatelessWidget {
  DirectoryGridFolderItem({
    @required this.item,
    @required this.onTapped,
  });

  final Folder item;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: style.textStyleNormal, child: _buildFolderItem(context));
  }

  Widget _buildFolderItem(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
            height: 80.0,
            child: Icon(
              Icons.folder,
              color: Colors.white,
              size: 80.0,
            )),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            item.name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTapped,
            child: Container(),
          ),
        ),
      ],
    );
  }

  Widget _buildFileItem(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
            height: 80.0,
            decoration: new ShapeDecoration(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.all(Radius.circular(8.0)),
                    side: new BorderSide(color: Colors.white, width: 1.0)
                    //side: new BorderSide(...)
                    )),
            child: Icon(
              Icons.insert_drive_file,
              color: Colors.white,
              size: 60.0,
            )),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            Text(
              item.name,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              formatLongDateTime(item.birthtime.toLocal()),
              style: TextStyle(fontSize: 14.0),
            ),
            Text(formatBytes((item as File).size, 2),
                style: TextStyle(fontSize: 14.0))
          ]),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTapped,
            child: Container(),
          ),
        ),
      ],
    );
  }
}
