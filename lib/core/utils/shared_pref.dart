import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<void> setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    return;
  }

  static Future<String> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key) ?? '';
    return value;
  }

  static Future<void> setBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    return;
  }

  static Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(key) ?? false;
    return value;
  }

  static Future<void> setInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
    return;
  }

  static Future<int> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(key) ?? 0;
    return value;
  }

  static Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  // Future<void> saveLoginSession(LoginModel response) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(Constants.authToken, response.token!);
  //   prefs.setInt(Constants.userId, response.data!.id!);
  //   prefs.setString(Constants.name, response.data!.name!);
  //   prefs.setString(Constants.email, response.data!.email!);
  //   prefs.setString(Constants.phoneNumber, response.data!.phoneNumber!);
  //   prefs.setString(Constants.userProfileImage, response.data!.profileImage!);
  //   prefs.setBool(Constants.isLogin, true);
  // }

  // Future<void> updateProfile(UpdatedProfile profile) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(Constants.name, profile.name!);
  //   prefs.setString(Constants.phoneNumber, profile.phoneNumber!);
  //   prefs.setString(Constants.userProfileImage, profile.profileImage!);
  // }
}
