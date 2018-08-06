import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/folder.dart';
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTapped,
        child: DefaultTextStyle(
            style: style.textStyleNormal, child: _buildFolderItem(context)),
      ),
    );
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
      ],
    );
  }
}
