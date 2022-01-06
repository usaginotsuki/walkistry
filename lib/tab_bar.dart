// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walkistry_flutter/src/models/user_model.dart';
import 'package:walkistry_flutter/src/pages/bike_routes_page.dart';
import 'package:walkistry_flutter/src/pages/walk_routes_page.dart';
import 'package:walkistry_flutter/src/pages/profile_page.dart';
import 'package:walkistry_flutter/src/providers/main_provider.dart';
import 'package:walkistry_flutter/src/widgets/profile_widget.dart';

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
        child: CustomScrollView(slivers: [
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return UserPage();
              },
              childCount: 1,
            ),
            itemExtent: 370,
          ),
          SliverAppBar(
            leading: Switch(
                value: mainProvider.mode,
                onChanged: (value) async {
                  mainProvider.mode = value;
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('mode', value);
                }),
            toolbarHeight: 70,
            expandedHeight: 0,
            floating: true,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: TabBar(
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
          SliverFillRemaining(
            child: TabBarView(
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
        ]));
  }
}
        /*appBar: AppBar(
          leading: Switch(
              value: mainProvider.mode,
              onChanged: (value) async {
                mainProvider.mode = value;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('mode', value);
              }),
        ),*/
        /*body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  floating: true,
                  pinned: true,
                  snap: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('Walkistry'),
                    background: ProfileWidget(),
                  ),
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
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
              ),
            ];
          },
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
          /*return <Widget>[
            SliverAppBar(
              snap: false,
              pinned: true,
              title: Text("Silver AppBar With ToolBar"),
              bottom: TabBar(
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
            SliverFillRemaining(
              child: TabBarView(
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
          ],
        */*/