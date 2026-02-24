import 'package:flutter/material.dart';
import '../models/user_settings_model.dart';
import '../core/services/settings_service.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsService _service = SettingsService();
  UserSettings _settings = UserSettings();

  UserSettings get settings => _settings;

  Future<void> loadSettings() async {
    _settings = await _service.loadSettings();
    notifyListeners();
  }

  Future<void> updateSettings(UserSettings newSettings) async {
    _settings = newSettings;
    await _service.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> updateAlertRadius(double radius) async {
    await updateSettings(_settings.copyWith(alertRadius: radius));
  }

  Future<void> toggleEarthquakeAlert(bool enabled) async {
    await updateSettings(_settings.copyWith(enableEarthquakeAlert: enabled));
  }

  Future<void> toggleLandslideAlert(bool enabled) async {
    await updateSettings(_settings.copyWith(enableLandslideAlert: enabled));
  }

  Future<void> updateMinMagnitude(double magnitude) async {
    await updateSettings(_settings.copyWith(minMagnitudeAlert: magnitude));
  }
}
