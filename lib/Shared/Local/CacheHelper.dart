import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<dynamic> setData({@required String? key, @required dynamic value}) async {
    if (value is bool) return await sharedPreferences.setBool(key!, value);
    if (value is double) return await sharedPreferences.setDouble(key!, value);
    if (value is int) return await sharedPreferences.setInt(key!, value);
    if (value is String) return await sharedPreferences.setString(key!, value);
  }

  static getData({@required dynamic key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeKey({@required key})
  {
    return sharedPreferences.remove(key);
  }
}
