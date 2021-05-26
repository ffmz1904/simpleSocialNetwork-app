import 'package:shared_preferences/shared_preferences.dart';

class TokenHandler {
  static Future setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    return token;
  }

  static Future removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
