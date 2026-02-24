import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_settings_model.dart';

class SettingsService {
  static const String _settingsKey = 'user_settings';

  Future<UserSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_settingsKey);
    
    if (jsonString != null) {
      return UserSettings.fromJson(json.decode(jsonString));
    }
    return UserSettings();
  }

  Future<void> saveSettings(UserSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_settingsKey, json.encode(settings.toJson()));
  }
}
