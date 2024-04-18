import 'package:shared_preferences/shared_preferences.dart';

/// to use this class, init it first in the main function [await LocalStorage.init()]
class LocalStorage {
  static late SharedPreferences pref;

  static Future init() async {
    pref = await SharedPreferences.getInstance();
  }

  // static 
}