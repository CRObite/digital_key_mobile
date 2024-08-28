import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_com/domain/access_user.dart';

class SharedPreferencesOperator {
  // Keys
  static const String keyCurrentUser = 'currentUser';

  // Generic method to save a value
  static Future<void> saveValue<T>(String key, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw UnsupportedError("Type not supported");
    }
  }

  // Generic method to get a value
  static Future<T?> getValue<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    } else {
      throw UnsupportedError("Type not supported");
    }
  }

  // Method to clear a value
  static Future<void> clearValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Method to check if a key exists
  static Future<bool> containsKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  // Specific methods for currentUser
  static Future<void> saveCurrentUser(String user) async {
    await saveValue(keyCurrentUser, user);
  }

  static Future<AccessUser?> getCurrentUser() async {
    String? data =  await getValue<String>(keyCurrentUser);

    if(data!= null){
      return AccessUser.fromJson(jsonDecode(data));
    }else {
      return null;
    }
  }

  static Future<void> clearCurrentUser() async {
    await clearValue(keyCurrentUser);
  }

  static Future<bool> containsCurrentUser() async {
    return containsKey(keyCurrentUser);
  }
}
