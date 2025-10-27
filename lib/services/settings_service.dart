import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_settings.dart';

class SettingsService {
  static const String _settingsKey = 'appSettings';

  Future<AppSettings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final String? settingsJson = prefs.getString(_settingsKey);
    
    if (settingsJson == null) {
      return const AppSettings();
    }
    
    try {
      final parts = settingsJson.split('|');
      return AppSettings(
        theme: parts[0],
        language: parts[1],
        categoriesEnabled: parts[2] == 'true',
      );
    } catch (e) {
      return const AppSettings();
    }
  }

  Future<void> saveSettings(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    final settingsString = '${settings.theme}|${settings.language}|${settings.categoriesEnabled}';
    await prefs.setString(_settingsKey, settingsString);
  }
}