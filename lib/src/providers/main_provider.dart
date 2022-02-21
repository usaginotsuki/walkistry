import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class MainProvider extends ChangeNotifier {
  bool _mode = true;
  String _token = "";
  String _userId = "";

  bool get mode => _mode;

  set mode(bool value) {
    _mode = value;
    notifyListeners();
  }

  String get userId => _userId;

  set userId(String value) {
    updateUID(value);
    _userId = value;
    notifyListeners();
    developer.log("userId: $value", name: "MainProvider - UID");
  }

  updateUID(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", value);
  }

  String get token {
    return this._token;
  }

  set token(String t) {
    _updateToken(t);
    _token = t;
    notifyListeners();
  }

  _updateToken(String t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", t);
  }

  Future<bool> initPrefs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = prefs.getString("token") ?? "";
      _mode = prefs.getBool('mode') ?? true;
      _userId = prefs.getString("userId") ?? "";
      return true;
    } catch (e) {
      return false;
    }
  }

  logout() async {
    updateUID("");
    _updateToken("");
    notifyListeners();
  }
}
