import 'package:flutter/material.dart';
class Login extends StatelessWidget {
  final _formKey=GlobalKey<FormState>();
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child:Column(
        children:[
          TextFormField(
      decoration: InputDecoration(
       // hintText: "Email",
        labelText: "Email",
          labelStyle: TextStyle(color: Color(0xFFee7b64),fontSize: 20,fontWeight: FontWeight.bold),
          prefixIcon:Icon(Icons.email_outlined,color: Color(0xFFee7b64),),
       enabledBorder: OutlineInputBorder(
           borderSide: BorderSide(color: Color(0xFFee7b64),width: 2),
             borderRadius: BorderRadius.circular(50),
         ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      ),

          ),

          SizedBox(height: 20,),
          TextFormField(
          decoration: InputDecoration(
        //  hintText: "Password",
    labelText: "Password",
    labelStyle: TextStyle(color: Color(0xFFee7b64),fontSize: 20,fontWeight: FontWeight.bold),
    prefixIcon:Icon(Icons.lock_open_outlined,color: Color(0xFFee7b64),),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFee7b64),width: 2),
    borderRadius: BorderRadius.circular(50),
    ), contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          ),
    ),


    ]
    ));
  }
}
