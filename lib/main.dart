// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:walkistry_flutter/src/pages/general_settings_page.dart';
import 'package:walkistry_flutter/src/pages/login_page.dart';
import 'package:walkistry_flutter/src/pages/signup_page.dart';
import 'package:walkistry_flutter/src/providers/main_provider.dart';
import 'package:walkistry_flutter/src/themes/app_theme.dart';
import 'tab_bar.dart';
import 'package:provider/provider.dart';

FirebaseApp defaultApp = Firebase.app();

void main() => runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MainProvider()),
        ],
        child: MyApp(
          mode: true,
        )));

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.mode}) : super(key: key);
  final bool? mode;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return FutureBuilder<bool>(
        future: mainProvider.initPrefs(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox.square(
              child: Center(
                child: Text('Error'),
              ),
            );
          }

          if (snapshot.hasData) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Material App',
                routes: {
                  "/login": (context) => const LoginPage(),
                  "/settings": (context) => const GeneralSettingsPage(),
                  "/signup": (context) => const SignUpPage(),
                },
                home: mainProvider.token == ""
                    ? const LoginPage()
                    : const HomeTabBar(),
                theme: AppTheme.themeData(mainProvider.mode));
          }
          return const SizedBox.square(
            child: Center(child: CircularProgressIndicator()),
          );

          /*MaterialApp(
            title: 'Material App',
            home: HomeTabBar(),
            theme: AppTheme.themeData(mode ?? true),*/
        });
  }
}
