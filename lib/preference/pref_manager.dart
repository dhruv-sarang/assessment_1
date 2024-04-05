import 'package:shared_preferences/shared_preferences.dart';

class PrefManager{

  static const _KEY_NAME = 'name';
  static const _KEY_EMAIL = 'email';
  static const _KEY_PASSWORD = 'password';
  static const _KEY_ISLOGIN = 'isLogin';

  static late SharedPreferences sharedPreferences;

  static Future<SharedPreferences> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  static Future<bool> createAccount(
      String name, String email, String password) async {
    try {
      await sharedPreferences.setString(_KEY_NAME, name);
      await sharedPreferences.setString(_KEY_EMAIL, email);
      await sharedPreferences.setString(_KEY_PASSWORD, password);
      await sharedPreferences.setBool(_KEY_ISLOGIN, true);

      return true;
    } catch (e) {
      return false;
    }
  }



  static String getName(String name) {
    return sharedPreferences.getString(PrefManager._KEY_NAME) ?? '';
  }

  static String getEmail(String eMail) {
    return sharedPreferences.getString(PrefManager._KEY_EMAIL) ?? '';
  }

  static String getPassword(String password) {
    return sharedPreferences.getString(PrefManager._KEY_PASSWORD) ?? '';
  }

  static bool getLoginStatus()  {
    return  sharedPreferences.getBool(PrefManager._KEY_ISLOGIN) ?? false;
  }



  static Future<bool> statusChange(bool st) async {
    try {
      await sharedPreferences.setBool(_KEY_ISLOGIN, st);

      return true;
    } catch (e) {
      return false;
    }
  }




}