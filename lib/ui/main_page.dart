import 'package:flutter/material.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/drive/drive_actions.dart';
import 'package:flutter_app/ui/drives/drives_page.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MainPage extends StatelessWidget {
  const MainPage();

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () {
          var store = StoreProvider.of<AppState>(context);
          store.dispatch(RefreshDrivesAction());
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('CoPi'),
        actions: _buildActions(context),
      ),
      body: DrivesPage(),
      bottomNavigationBar: new BottomNavigationBar(items: [
        new BottomNavigationBarItem(
          icon: const Icon(Icons.queue),
          title: new Text('Copy'),
        ),
        new BottomNavigationBarItem(
          icon: const Icon(Icons.sd_card),
          title: new Text('Drives'),
        )
      ]),
    );
  }
}
