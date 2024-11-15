import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_com/domain/access_user.dart';

class SharedPreferencesOperator {
  // Keys
  static const String keyCurrentUser = 'currentUser';
  static const String keyOnBoard = 'onBoard';

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

  static Future<void> clearValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<bool> containsKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<void> saveCurrentUser(String user) async {
    print('saved');
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


  static Future<void> saveOnBoardStatus(bool status) async {
    print('saved');
    await saveValue(keyOnBoard, status);
  }

  static Future<bool> getOnBoardStatus() async {
    bool? data =  await getValue<bool>(keyOnBoard);

    if(data!= null){
      return data;
    }else {
      return false;
    }
  }

  static Future<void> clearOnBoardStatus() async {
    await clearValue(keyOnBoard);
  }

  static Future<bool> containsOnBoardStatus() async {
    return containsKey(keyOnBoard);
  }
}
