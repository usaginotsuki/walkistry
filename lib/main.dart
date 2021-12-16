import 'package:flutter/material.dart';
import 'package:walkistry_flutter/src/pages/home_page.dart';
import 'tab_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        accentColor: Colors.red,
      ),
    );
  }
}
