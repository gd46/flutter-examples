import 'package:flutter/material.dart';
import 'package:flutter_sample_app/models/app_settings_model.dart';

class AppSettingsNotifier with ChangeNotifier {
  final AppSettings appSettings = AppSettings();
  bool _isDarkModeEnabled = false;

  bool get isDarkModeEnabled => _isDarkModeEnabled;

  set isDarkModeEnabled(bool value) {
    _isDarkModeEnabled = value;
    appSettings.setDarkModeEnabled(value);
    notifyListeners();
  }

  Future<bool> clear() async {
    final bool _isSettingsCleared = await appSettings.clear();
    return _isSettingsCleared;
  }
}
