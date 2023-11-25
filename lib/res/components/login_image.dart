import 'package:flutter/material.dart';
class LoginImage extends StatelessWidget {
  const LoginImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Text("Chat Room",style:TextStyle(fontSize: 40,fontWeight: FontWeight.bold)),
    SizedBox(height: 10,),
    Text("Login now to see what they are talking!",
        style:TextStyle(fontSize: 18,fontWeight: FontWeight.w400)),
    SizedBox(height: 40,),
    Image(image: AssetImage("assets/images/login.png",),
      fit: BoxFit.contain,
    ),
],  ));
  }
}

