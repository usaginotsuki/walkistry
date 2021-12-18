// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walkistry_flutter/src/themes/app_theme.dart';
import 'tab_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _setupMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomeTabBar(),
      theme: AppTheme.themeData(false),
    );
  }

  _setupMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('mode', true);
    bool? mode = prefs.getBool('mode');
  }
}
