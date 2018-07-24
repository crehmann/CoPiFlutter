import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/drive.dart';

class DirectoryPage extends StatelessWidget {
  DirectoryPage(this.drive);

  final Drive drive;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white);
  }
}
