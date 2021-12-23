// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walkistry_flutter/src/pages/bike_routes_page.dart';
import 'package:walkistry_flutter/src/pages/walk_routes_page.dart';
import 'package:walkistry_flutter/src/pages/profile_page.dart';
import 'package:walkistry_flutter/src/providers/main_provider.dart';

class HomeTabBar extends StatefulWidget {
  const HomeTabBar({Key? key}) : super(key: key);

  @override
  _HomeTabBarState createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: Switch(
              value: mainProvider.mode,
              onChanged: (value) async {
                mainProvider.mode = value;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('mode', value);
              }),
          title: const TabBar(
            tabs: [
              Tab(
                text: 'Caminar',
                icon: Icon(Icons.directions_walk),
              ),
              Tab(
                text: 'Bicicleta',
                icon: Icon(Icons.directions_bike),
              ),
              Tab(
                icon: Icon(Icons.group),
                text: 'Grupos',
              ),
              Tab(icon: Icon(Icons.person), text: 'Perfil'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomePage(),
            BikeRoutesPage(),
            const Center(
              child: Text('Search'),
            ),
            UserPage()
          ],
        ),
      ),
    );
  }
}
