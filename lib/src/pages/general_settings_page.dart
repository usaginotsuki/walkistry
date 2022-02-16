//Dart settings page
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walkistry_flutter/src/pages/login_page.dart';
import 'package:walkistry_flutter/src/providers/main_provider.dart';
import 'dart:developer' as developer;

class GeneralSettingsPage extends StatelessWidget {
  const GeneralSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    Map<String, dynamic> contentJWT = JwtDecoder.decode(mainProvider.token);
    developer.log(contentJWT.toString());
    bool DarkMode = mainProvider.mode;
    return Scaffold(
      appBar: AppBar(
        title: Text('General Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Modo oscuro'),
            leading: Switch(
                value: mainProvider.mode,
                onChanged: (value) async {
                  mainProvider.mode = value;
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  DarkMode = !DarkMode;
                  prefs.setBool('mode', value);
                }),
            subtitle: DarkMode
                ? Text('Modo oscuro activado')
                : Text('Modo oscuro desactivado'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: Text('Cerrar sesión'),
            leading: Icon(Icons.exit_to_app),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              mainProvider.token = '';
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(pageBuilder: (BuildContext context,
                      Animation animation, Animation secondaryAnimation) {
                    return LoginPage();
                  }, transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return new SlideTransition(
                      position: new Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  }),
                  (Route route) => false);
            },
          ),
          ListTile(
              leading: Icon(Icons.person),
              title: Text(contentJWT['user_id'].toString()),
              subtitle: const Text("Nombre")),
        ],
      ),
    );
  }
}
