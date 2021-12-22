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

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool? _mode;
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _setupPreferences();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {});
    }
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomeTabBar(),
      theme: AppTheme.themeData(_mode ?? true),
    );
  }

  _setupPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _mode = prefs.getBool('mode') ?? true;
    setState(() {});
  }
}
