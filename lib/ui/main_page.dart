import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/ui/copyjob/copy_job_create_page.dart';
import 'package:flutter_app/ui/copyjob/copy_job_list_page.dart';
import 'package:flutter_app/ui/drives/drives_page.dart';
import 'package:flutter_app/ui/settings/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  TabController _controller;
  AnimationController _animationController;
  Animation<double> _animateFab;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(_animate);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    _animateFab =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
  }

  void _animate() {
    if (_controller.index == 1) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _openCopJobCreatePage(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return new CopyJobCreatePage();
      },
    ));
  }

  void _openSettingsPage(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return new SettingsPage();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("CoPi"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              _openSettingsPage(context);
            },
          )
        ],
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
      floatingActionButton: Opacity(
          opacity: _animateFab.value,
          child: FloatingActionButton(
            onPressed: () => _openCopJobCreatePage(context),
            child: Icon(Icons.add),
          )),
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
