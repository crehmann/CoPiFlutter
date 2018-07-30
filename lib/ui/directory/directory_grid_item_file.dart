import 'package:flutter/material.dart';
import 'package:flutter_app/models/file.dart';
import 'package:flutter_app/utils/formatter.dart';
import 'package:meta/meta.dart';
import 'package:flutter_app/ui/style.dart' as style;
import 'package:flutter_app/globals.dart' as globals;

class DirectoryGridFileItem extends StatelessWidget {
  DirectoryGridFileItem({
    @required this.item,
    @required this.onTapped,
  });

  final File item;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onTapped,
            child: DefaultTextStyle(
                style: style.textStyleNormal, child: _buildFileItem(context))));
  }

  Widget _buildFileItem(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildPreview(context),
            Container(
              child: Column(children: <Widget>[
                Text(
                  item.name,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  formatLongDateTime(item.creationTime.toLocal()),
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(formatBytes(item.size, 2),
                    style: TextStyle(fontSize: 14.0))
              ]),
            ),
          ],
        ));
  }

  Widget _buildPreview(BuildContext context) {
    final borderRadius = new BorderRadius.all(Radius.circular(8.0));
    return item.previewLink.isPresent
        ? new Container(
            child: new Container(
              decoration: new ShapeDecoration(
                  shape: new RoundedRectangleBorder(
                      borderRadius: borderRadius,
                      side: new BorderSide(color: Colors.white, width: 1.0)
                      //side: new BorderSide(...)
                      )),
              child: ClipRRect(
                  borderRadius: borderRadius,
                  child: Image.network(
                    globals.baseUri.toString() + item.previewLink.value,
                  )),
            ),
            padding: EdgeInsets.all(16.0),
          )
        : Icon(
            Icons.insert_drive_file,
            color: Colors.white,
            size: 60.0,
          );
  }
}
