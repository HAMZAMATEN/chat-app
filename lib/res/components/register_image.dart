import 'package:flutter/material.dart';
class RegisterImage extends StatelessWidget {
  const RegisterImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Chat Room",style:TextStyle(fontSize: 40,fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            Text("Login now to see what they are talking!",
                style:TextStyle(fontSize: 19,fontWeight: FontWeight.w500)),
            Image(image: AssetImage("assets/images/register.png",),
              fit: BoxFit.contain,
            ),
          ],  ));
  }
}

