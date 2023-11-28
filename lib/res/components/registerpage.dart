// import 'package:chat_app/Helper/helper_function.dart';
// import 'package:chat_app/pages/HomeScreen/home.dart';
// import 'package:chat_app/pages/auth/login.dart';
// import 'package:chat_app/res/components/snackbar.dart';
// import 'package:chat_app/services/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:chat_app/res/components/navigate_function.dart';
// import 'package:flutter/gestures.dart';
//
// import '../colors/color.dart';
// class Register extends StatefulWidget {
//   final bool isLoading;
//   final Function(bool) setLoading;
//   Register({Key? key,required this.isLoading,required this.setLoading}) : super(key: key);
//   @override
//   State<Register> createState() => _RegisterState();
//
// }
// class _RegisterState extends State<Register> {
//   final _formKey = GlobalKey<FormState>();
//   String email = "";
//   String password = "";
//   String fullName = "";
// AuthService authService=AuthService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey, child:
//     Column(
//         children: [
//           TextFormField(
//               decoration: InputDecoration(
//                 labelText: "Full Name",
//                 labelStyle: TextStyle(color: Color(0xFFee7b64),
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//                 prefixIcon: Icon(Icons.person, color: Color(0xFFee7b64),),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     style: BorderStyle.solid,
//                     color: Color(0xFFee7b64),
//                     width: 2,),
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 contentPadding: EdgeInsets.symmetric(
//                     horizontal: 20, vertical: 20),
//               ),
//               onChanged: (val) {
//                 setState(() {
//                   fullName = val;
//                 });
//               }, //check the validator
//               validator: (val) {
//                 if (val!.isNotEmpty) {
//                   return null;
//                 } else {
//                   return ("Name cannot be empty");
//                 }
//               }),
//           SizedBox(height: 10,),
//           TextFormField(
//               decoration: InputDecoration(
//                 // hintText: "Email",
//                 labelText: "Email",
//                 labelStyle: TextStyle(color: Color(0xFFee7b64),
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//                 prefixIcon: Icon(
//                   Icons.email_outlined, color: Color(0xFFee7b64),),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     style: BorderStyle.solid,
//                     color: Color(0xFFee7b64),
//                     width: 2,),
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 contentPadding: EdgeInsets.symmetric(
//                     horizontal: 20, vertical: 20),),
//               onChanged: (val) {
//                 setState(() {
//                   email = val;
//                 });
//               }, //check the validator
//               validator: (val) {
//                 return RegExp(
//                     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                     .hasMatch(val!) ? null : "please enter a valid email";
//               }),
//           SizedBox(height: 10),
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
//           SizedBox(height: 50,
//               width: double.infinity,
//               child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primaryColor,
//                       elevation: 0),
//
//                   onPressed: () {
//                     widget.setLoading(true);
//                     register();
//                   },
//                   child: Text("Register", style: TextStyle(
//                       fontSize: 20, color: AppColors.whiteColor),),
//              ),
//           ),
//           SizedBox(height: 10,),
//           Text.rich(TextSpan(
//               text: "Already have an account? ",
//               style: TextStyle(fontSize: 18, color: Colors.black,),
//               children: [
//                 TextSpan(
//                   text: "Login here",
//                   style: TextStyle(fontSize: 18,
//                       color: Colors.black,
//                       decoration: TextDecoration.underline),
//                   recognizer: TapGestureRecognizer()..onTap=(){
//                     nextScreen(context, LoginPage());
//
//                   })
//
//               ]
//
//           ),
//           )
//         ]),
//
//
//     );
//   }
//     register() async {
//     if(_formKey.currentState!.validate()){
//       widget.setLoading(true);
//       await authService.registerUserWithEmailAndPassword(fullName, email, password).then((value) async {
//         if(value==true){
//           //saving shared preference state
//           await HelperFunction.saveUserLoggedInStatus(true);
//           await HelperFunction.saveUserNameSP(fullName);
//           await HelperFunction.saveUserEmailSp(email);
//           nextScreenReplacement(context, HomePage());
//         }else {
//           showSnackBar(context, Colors.redAccent, value);
//           setState(() {
//           widget.setLoading(false);
//           });
//         }
//
//
//       });
//         }
//
//     }
//
//     }
//
//
//
//
//



















