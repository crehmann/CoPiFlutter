import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/ui/copyjob/copy_job_list_page.dart';
import 'package:flutter_app/ui/drives/drives_page.dart';

class MainPage extends StatefulWidget {
  const MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("CoPi"),
        bottom: TabBar(
          controller: _controller,
          tabs: const <Tab>[
            const Tab(
              text: 'Copy Jobs',
              icon: Icon(Icons.queue),
            ),
            const Tab(
              text: 'Drives',
              icon: Icon(Icons.sd_card),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          CopyJobListPage(),
          DrivesPage(),
        ],
      ),
    );
  }
}
