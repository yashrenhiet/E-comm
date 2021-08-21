import 'package:e_comm_app/features/_model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static const _USER_KEY = "LOGGED_IN_USER";

  static saveUse(User? user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user == null)
      await prefs.remove(_USER_KEY);
    else
      await prefs.setString(_USER_KEY, "value");
  }

  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_USER_KEY);
    // TODO parse json string back to user object
    if (jsonString == null) return null;
    return User("default@email.com", "password");
  }
}
