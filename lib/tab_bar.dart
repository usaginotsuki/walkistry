import 'package:flutter/material.dart';

class HomeTabBar extends StatefulWidget {
  HomeTabBar({Key? key}) : super(key: key);

  @override
  _HomeTabBarState createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Walkistry'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Caminata',
                icon: Icon(Icons.directions_walk),
              ),
              Tab(
                icon: Icon(Icons.search),
              ),
              Tab(
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text('Home'),
            ),
            Center(
              child: Text('Search'),
            ),
            Center(
              child: Text("Third"),
            )
          ],
        ),
      ),
    );
  }
}
