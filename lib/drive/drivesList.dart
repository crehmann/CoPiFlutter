import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/drive/drive.dart';
import 'package:flutter_app/utils.dart';
import 'package:http/http.dart' as http;

Widget futureDriveList() {
  return FutureBuilder<List<Drive>>(
    future: fetchDrives(http.Client()),
    builder: (context, snapshot) {
      if (snapshot.hasError) print(snapshot.error);

      return snapshot.hasData
          ? _DrivesList(drives: snapshot.data)
          : Center(child: CircularProgressIndicator());
    },
  );
}

class _DrivesList extends StatelessWidget {
  final List<Drive> drives;

  _DrivesList({Key key, this.drives}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
            leading: Icon(Icons.sd_card),
            title: Text(drives[0].description),
            subtitle: Text(formatBytes(drives[0].size, 2)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                        appBar: AppBar(),
                        body: Center(child: Text("Hi")),
                      ),
                ),
              );
            });
      },
      itemCount: drives.length,
    );
  }
}
