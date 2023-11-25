import 'package:chat_app/res/components/loginpage.dart';
import 'package:flutter/material.dart';

import '../../res/components/login_image.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor:Color(0xFFee7b64)),
      body:SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 80),
            child: Column(
         children:[
           LoginImage(),
           Login(),


         ],


        
        
        ),),
    );



  }
}


