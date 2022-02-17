// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:walkistry_flutter/src/pages/general_settings_page.dart';
import 'package:walkistry_flutter/src/pages/login_page.dart';
import 'package:walkistry_flutter/src/pages/signup_page.dart';
import 'package:walkistry_flutter/src/providers/main_provider.dart';
import 'package:walkistry_flutter/src/themes/app_theme.dart';
import 'tab_bar.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

FirebaseApp defaultApp = Firebase.app();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  developer.log('Message received: ${message.data}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title}
      description: 'Dos puntos',
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MainProvider()),
        ],
        child: MyApp(
          mode: true,
        )));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.mode}) : super(key: key);
  final bool? mode;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
