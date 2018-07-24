import 'package:flutter/material.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/drive/drive_actions.dart';
import 'package:flutter_app/ui/drives/drives_page.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MainPage extends StatefulWidget {
  const MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  void _refreshDrives() {
    var store = StoreProvider.of<AppState>(context);
    store.dispatch(RefreshDrivesAction());
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: _refreshDrives,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('CoPi'),
        actions: _buildActions(),
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
