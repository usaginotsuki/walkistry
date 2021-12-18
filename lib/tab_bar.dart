import 'package:flutter/material.dart';
import 'package:walkistry_flutter/src/pages/home_page.dart';

class HomeTabBar extends StatefulWidget {
  const HomeTabBar({Key? key}) : super(key: key);

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
          title: const Text('Walkistry'),
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
            HomePage(),
            const Center(
              child: Text('Search'),
            ),
            const Center(
              child: Text("Third"),
            )
          ],
        ),
      ),
    );
  }
}
