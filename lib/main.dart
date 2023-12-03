import 'package:chat_app/Helper/helper_function.dart';
import 'package:chat_app/pages/HomeScreen/home.dart';
import 'package:chat_app/pages/auth/login.dart';
import 'package:chat_app/res/components/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyAaMFaAYlBN9aFWAj1dgwEmdtKg2ZyI0dg',
          appId: '1:619966241564:android:6dd9192177f9d7314f78d9',
          messagingSenderId: '',
          projectId: 'chat-app-b04ae'),
    );
    runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn=false;
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
  }
  //fetch data
  getUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then((value){
      if (value!=null){
        setState(() {
          _isSignedIn=value;
        });

      }
    });
}

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primaryColor:Color(0xFFee7b64),
      // ),
      home: _isSignedIn ? HomePage():LoginPage(),
    );
  }
}
