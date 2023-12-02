import 'package:chat_app/pages/auth/register.dart';
import 'package:chat_app/res/components/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../Helper/helper_function.dart';
import '../../res/colors/color.dart';
import '../../res/components/login_image.dart';
import '../../res/components/navigate_function.dart';
import '../../res/components/snackbar.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../HomeScreen/home.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  AuthService authService=AuthService();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor:Color(0xFFee7b64)),
      body:_isLoading ? Center(child:CircularProgressIndicator(color: Colors.red,) ,):SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 80),
    child:Form(
    key: _formKey, child:
    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
           LoginImage(),
         TextFormField(
              decoration: InputDecoration(
                // hintText: "Email",
                labelText: "Email",
                labelStyle: TextStyle(color: Color(0xFFee7b64),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                prefixIcon: Icon(Icons.email_outlined, color: Color(0xFFee7b64),),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Color(0xFFee7b64),
                    width: 2,),
                  borderRadius: BorderRadius.circular(50),
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),),
              onChanged: (val) {
                setState(() {
                  email = val;
                });
                print(email);
              }, //check the validator
              validator: (val) {
                return RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val!) ? null : "please enter a valid email";
              }),
            SizedBox(height: 20),
            TextFormField(obscureText: true, decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(color: Color(0xFFee7b64),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              prefixIcon: Icon(
                Icons.lock_open_outlined, color: Color(0xFFee7b64),),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid, color: Color(0xFFee7b64), width: 2,),
                borderRadius: BorderRadius.circular(50),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            ),
                validator: (val) {
                  if (val!.length < 6) {
                    return "password must be at least 6 characters";
                  } else {
                    return null;
                  }
                }, onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                }
            ),
            SizedBox(height: 20,),
            SizedBox(height:50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor,
                        elevation: 0),

                    onPressed: (){
                      login();
                    },
                    child:Text("Sign In",style: TextStyle(fontSize: 20,color: Colors.white),))
            ),
            SizedBox(height: 10,),
            Text.rich(TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(fontSize: 18,color: Colors.black,),
                children:[
                  TextSpan(
                    text: "Register here",
                    style: TextStyle(fontSize: 18,color: Colors.black,decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()..onTap=(){
                      nextScreen(context,RegisterPage() );

                    },
                  ),
                ]

            ),
            )
          ]),


      ),
    ));
    }
    login() async {
      if(_formKey.currentState!.validate()) {
        setState(() {
          _isLoading=true;
        });
      }
      await authService.LoginUserWithEmailAndPassword( email, password).then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
          await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(email);
          //saving shared preference state
          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserNameSP(snapshot.docs[0]["fullName"]);
          await HelperFunction.saveUserEmailSp(email);
          nextScreenReplacement(context, HomePage());
        } else {
          showSnackBar(context, Colors.redAccent, value);
          setState(() {
          _isLoading=false;
          });
        }


      });
    }

  }



