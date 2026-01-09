import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static Future<String> loadProfile(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? 'Guest';
  }

  static Future<void> setPrefs<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw Exception('Unsupported type');
    }
  }
}
