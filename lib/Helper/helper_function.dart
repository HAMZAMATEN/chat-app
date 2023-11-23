import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  //used  shared preferences to check user is login or not

  //keys
 static String userLoggedInKey="LOGGEDINKEY";
 static String userNameKey="USERNAMEKEY";
 static String userEmailKey="USEREMAILKEY";

  //saving data to SP



  //getting data from SP
static Future<bool?>getUserLoggedInStatus() async{
 SharedPreferences sp=await SharedPreferences.getInstance();
 return sp.getBool (userLoggedInKey);

}






}