import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  //::::::::::::::::::::::::: Save and Get String Value ::::::::::::::::::::::::
  static Future<bool> saveStringValueToSp(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }
  static Future<String?> getStringValueFromSp(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  
  //::::::::::::::::::::::: Save and Get Boolean Value :::::::::::::::::::::::::
  static Future<bool> saveBoolValueToSp(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool?> getBoolValueFromSp(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  //:::::::::::::::::::::::: Save and Get Integer Value ::::::::::::::::::::::::
  static Future<bool> saveIntegerValueToSp(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }
  static Future<int?> getIntegerValueFromSp(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  //::::::::::::::::::::::::::::::: Delete Value :::::::::::::::::::::::::::::::
  static Future<bool?> deleteValueFromSP(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}