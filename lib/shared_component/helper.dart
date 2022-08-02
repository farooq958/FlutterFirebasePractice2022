import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceVerifyKey = "Verify";

  /// saving data to shared preference

  static Future<bool> saveVerificationIdSharedPreference(
      String verificationId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        sharedPreferenceVerifyKey, verificationId);
  }

  /// fetching data from shared preference

  static Future<String> getUserEmailSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    debugPrint(preferences.getString(sharedPreferenceVerifyKey).toString());
    return preferences.getString(sharedPreferenceVerifyKey).toString();
  }
}
