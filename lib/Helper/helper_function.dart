import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  //used  shared preferences to check user is login or not

  //keys
 static String userLoggedInKey="LOGGEDINKEY";
 static String userNameKey="USERNAMEKEY";
 static String userEmailKey="USEREMAILKEY";

  //saving data to SP
 static Future<bool>saveUserLoggedInStatus(bool isUserLoggedIn)async{
  SharedPreferences sp=await SharedPreferences.getInstance();
  return await  sp.setBool(userLoggedInKey, isUserLoggedIn);
 }
 static Future<bool>saveUserNameSP(String userName)async{
  SharedPreferences sp=await SharedPreferences.getInstance();
  return await sp.setString (userNameKey, userName);
 }
 static Future<bool>saveUserEmailSp(String userEmail)async{
  SharedPreferences sp=await SharedPreferences.getInstance();
  return await sp.setString (userEmailKey, userEmail);
 }



  //getting data from SP
static Future<bool?>getUserLoggedInStatus() async {
 SharedPreferences sp = await SharedPreferences.getInstance();
 return sp.getBool(userLoggedInKey);
}
 static Future<String?>getUserEmailFromSF() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  return sp.getString(userEmailKey);
 }
  static Future<String?>getUserNameFromSF() async{
   SharedPreferences sp=await SharedPreferences.getInstance();
   return sp.getString(userNameKey);
}






}