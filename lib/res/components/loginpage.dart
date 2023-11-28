// import 'package:chat_app/pages/auth/register.dart';
// import 'package:chat_app/res/components/navigate_function.dart';
// import 'package:chat_app/res/components/snackbar.dart';
// import 'package:chat_app/services/auth_service.dart';
// import 'package:chat_app/services/database_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// import '../../Helper/helper_function.dart';
// import '../../pages/HomeScreen/home.dart';
// import '../colors/color.dart';
// class Login extends StatefulWidget {
//   final bool isLoading;
//   final Function(bool) setLoading;
//   Login({Key? key,required this.isLoading,required this.setLoading}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
//  // bool get isLoading => _LoginState(). _isLoading;
// }
//
// class _LoginState extends State<Login> {
//
//   final _formKey = GlobalKey<FormState>();
//   String email = "";
//   String password = "";
//   AuthService authService=AuthService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey, child:
//     Column(
//         children: [TextFormField(
//             decoration: InputDecoration(
//               // hintText: "Email",
//               labelText: "Email",
//               labelStyle: TextStyle(color: Color(0xFFee7b64),
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//               prefixIcon: Icon(Icons.email_outlined, color: Color(0xFFee7b64),),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   style: BorderStyle.solid,
//                   color: Color(0xFFee7b64),
//                   width: 2,),
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               contentPadding: EdgeInsets.symmetric(
//                   horizontal: 20, vertical: 20),),
//             onChanged: (val) {
//               setState(() {
//                 email = val;
//               });
//               print(email);
//             }, //check the validator
//             validator: (val) {
//               return RegExp(
//                   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                   .hasMatch(val!) ? null : "please enter a valid email";
//             }),
//           SizedBox(height: 20),
//           TextFormField(obscureText: true, decoration: InputDecoration(
//             labelText: "Password",
//             labelStyle: TextStyle(color: Color(0xFFee7b64),
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold),
//             prefixIcon: Icon(
//               Icons.lock_open_outlined, color: Color(0xFFee7b64),),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                 style: BorderStyle.solid, color: Color(0xFFee7b64), width: 2,),
//               borderRadius: BorderRadius.circular(50),
//             ),
//             contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           ),
//               validator: (val) {
//                 if (val!.length < 6) {
//                   return "password must be at least 6 characters";
//                 } else {
//                   return null;
//                 }
//               }, onChanged: (val) {
//                 setState(() {
//                   password = val;
//                 });
//               }
//           ),
//           SizedBox(height: 20,),
//           SizedBox(height:50,
//               width: double.infinity,
//              child: ElevatedButton(
//                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor,
//                elevation: 0),
//
//                  onPressed: (){
//                  login();
//                  },
//                   child:Text("Sign In",style: TextStyle(fontSize: 20,color: AppColors.whiteColor),))
//           ),
//           SizedBox(height: 10,),
//           Text.rich(TextSpan(
//             text: "Don't have an account? ",
//     style: TextStyle(fontSize: 18,color: Colors.black,),
//             children:[
//               TextSpan(
//                 text: "Register here",
//                 style: TextStyle(fontSize: 18,color: Colors.black,decoration: TextDecoration.underline),
//     recognizer: TapGestureRecognizer()..onTap=(){
//                   nextScreen(context,RegisterPage() );
//
//               },
//     ),
//     ]
//
//             ),
//           )
//     ]),
//
//
//     );
//   }
//   login() async {
//     if(_formKey.currentState!.validate()) {
//       setState(() {
//         widget.setLoading(true);
//       });
//     }
//       await authService.LoginUserWithEmailAndPassword( email, password).then((value) async {
//         if (value == true) {
//           QuerySnapshot snapshot =
//           await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
//               .gettingUserData(email);
//           //saving shared preference state
//           await HelperFunction.saveUserLoggedInStatus(true);
//           await HelperFunction.saveUserNameSP(snapshot.docs[0]["fullName"]);
//           await HelperFunction.saveUserEmailSp(email);
//           nextScreenReplacement(context, HomePage());
//         } else {
//           showSnackBar(context, Colors.redAccent, value);
//           setState(() {
//             widget.setLoading(false);
//           });
//         }
//
//
//       });
//   }
//
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
