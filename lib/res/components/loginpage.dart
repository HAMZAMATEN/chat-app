import 'package:flutter/material.dart';
class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey=GlobalKey<FormState>();
  String email="";
  String password="";  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,child:
     Column(
children:[TextFormField(
      decoration: InputDecoration(
       // hintText: "Email",
        labelText: "Email",
          labelStyle: TextStyle(color: Color(0xFFee7b64),fontSize: 20,fontWeight: FontWeight.bold),
          prefixIcon:Icon(Icons.email_outlined,color: Color(0xFFee7b64),),
       enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.solid,color: Color(0xFFee7b64),width: 2,),
             borderRadius: BorderRadius.circular(50),
         ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),     ),
        onChanged:(val){
    setState((){email=val;});
print(email);
    },//check the validator
        validator:(val){return RegExp(   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ?null:"please enter a valid email";}),
SizedBox(height:20),
    TextFormField( obscureText:true,decoration:InputDecoration(
      labelText: "Password",
   labelStyle:TextStyle(color: Color(0xFFee7b64),fontSize: 20,fontWeight: FontWeight.bold),
    prefixIcon:Icon(Icons.lock_open_outlined,color: Color(0xFFee7b64),),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(style: BorderStyle.solid,color:Color(0xFFee7b64),width: 2,),
    borderRadius: BorderRadius.circular(50),
    ), contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          ),
    validator:(val){
    if(val!.length<6){
    return "password must be at least 6 characters";
    }else{
    return null;}
},  onChanged:(val){
    setState((){
    email=val;
    });
    }
    ),
ElevatedButton(onPressed: (){
login(); }, child:Text("Test"),),

]
      ), );}
//here i create function for validation// }
login(){
if(_formKey.currentState!.validate());
}
}





























