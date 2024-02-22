import 'package:shared_preferences/shared_preferences.dart';

//sharedpreferences는 간단한 값을 저장할때 쓰인다, 간단한값을 DB에 쓰는 것은 복잡하기때문
class Helperfunctions{
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  //saving data to SharedPreference

  static Future<bool?> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool?> saveUserNameSharedPreference(String username) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, username);
  }

  static Future<bool?> saveUserEmailSharedPreference(String useremail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, useremail);
  }

  static Future<bool?> getUserLoggedInSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String?> getUserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String?> getUserEmailSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserEmailKey);
  }

  
}