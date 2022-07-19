import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{


  static String sharedPreferenceVerifyKey = "Verify";

  /// saving data to sharedpreference

  static Future<bool> saveverificationidSharedPreference(String verificationid) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceVerifyKey, verificationid);
  }

  /// fetching data from sharedpreference




  static Future<String> getUserEmailSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    debugPrint(preferences.getString(sharedPreferenceVerifyKey).toString());
    return  preferences.getString(sharedPreferenceVerifyKey).toString();
  }

}