import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/copy_job.dart';
import 'package:flutter_app/ui/copyjob/copy_job_list_tile.dart';

class CopyJobDetailsPage extends StatelessWidget {
  CopyJobDetailsPage({@required this.copyJob});

  final CopyJob copyJob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CopyJob Details"),
          centerTitle: Platform.isIOS,
        ),
        body: Scrollbar(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CopyJobListTile(copyJob: copyJob, clickable: false),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Output:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(copyJob.output.join("\n")),
                  SizedBox(height: 16.0),
                  Text(
                    "Errors:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(copyJob.error ?? "none")
                ],
              ),
            )
          ],
        )));
  }
}
