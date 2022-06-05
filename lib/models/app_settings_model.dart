import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  static const darkModeEnabled = "DARK_MODE_ENABLED";

  setDarkModeEnabled(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(darkModeEnabled, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(darkModeEnabled) ?? false;
  }

  Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
