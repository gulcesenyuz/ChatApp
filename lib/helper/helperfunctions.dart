import 'package:shared_preferences/shared_preferences.dart';
//SharedPreferences= veriyi kaydeder. giriş bilgileri vs
class  HelperFunctions{
  static String sharedPreferenceUserLoggedInKey= "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey= "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey= "USEREMAILKEY";

  //SAVE DATA TO SHARED PREFERENCES
  //Async means that this function is asynchronous
  // and you might need to wait a bit to get its result.
  //Await literally means - wait here until this function
  // is finished and you will get its return value.
  //Future is a type that ‘comes from the future’ and
  // returns value from your asynchronous function.
  // It can complete with success(.then) or with
  // an error(.catchError).
  static Future <bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }
  static Future <bool> saveUserNameSharedPreference(
      String userName) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }
  static Future <bool> saveUserEmailSharedPreference(
      String userEmail) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

//GET DATA TO SHARED PREFERENCES
  static Future  getUserLoggedInSharedPreference() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserLoggedInKey);
  }
  static Future <void> getUserNameSharedPreference() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserNameKey);
  }
  static Future <void> getUserEmailSharedPreference() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserEmailKey);
  }

}