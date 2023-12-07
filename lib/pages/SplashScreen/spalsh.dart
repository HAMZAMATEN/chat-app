import 'package:chat_app/pages/auth/login.dart';
import 'package:chat_app/res/components/navigate_function.dart';
import 'package:flutter/material.dart';

import '../../Helper/helper_function.dart';
import '../HomeScreen/home.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isSignedIn=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
  }
  //fetch data
  getUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
        Future.delayed(Duration(seconds: 3),(){
          nextScreen(context, _isSignedIn ? HomePage():LoginPage());
        });

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.center,
          children:[
                Text("Chat Room",style:TextStyle(fontSize: 40,fontWeight: FontWeight.bold)),
                  SizedBox(height: 40,),
           Text("Stay connected with your contacts\n no matter where they are.",style:TextStyle(
                      fontSize: 22,fontWeight: FontWeight.w600)),
                  SizedBox(height: 20,),
                  Image.asset("assets/images/1.png",),
          ]
               ),

            ),



            ),

        );


  }
}

