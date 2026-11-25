import 'package:shared_preferences/shared_preferences.dart';

class tokenSimplePreferences {
  static SharedPreferences? _preferences;

  static const _token = 'token';


  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future settoken(String token) async =>
      await _preferences!.setString(_token, token);

  static String? gettoken() => _preferences!.getString(_token);

}