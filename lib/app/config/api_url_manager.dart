import 'package:shared_preferences/shared_preferences.dart';

class ApiUrlManager {
  static const String _key = 'api_url';

  static Future<String> get() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_key) ?? '';
  }

  static Future<void> insert(String url) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_key, url);
  }
}
