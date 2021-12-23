import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {
  bool _mode = true;

  bool get mode => _mode;

  set mode(bool value) {
    _mode = value;
    notifyListeners();
  }

  Future<bool> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _mode = prefs.getBool('mode') ?? true;
    return _mode;
  }
}
