import 'package:flutter/material.dart';
import 'package:flutter_app/ui/drives/drives_page.dart';
import 'package:flutter/cupertino.dart';

class MainPage extends StatelessWidget {
  const MainPage();

  Widget _buildCopyPage() {
    return CupertinoTabView(builder: (BuildContext context) {
      return CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text("Copy Jobs"),
            ),
            SliverFillRemaining()
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new CupertinoTabScaffold(
      tabBar: new CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(title: Text("Copy"), icon: Icon(Icons.queue)),
          BottomNavigationBarItem(
              title: Text("Drives"), icon: Icon(Icons.sd_card))
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return index == 0
            ? _buildCopyPage()
            : CupertinoTabView(builder: (BuildContext context) {
                return DrivesPage();
              });
      },
    );
  }
}
