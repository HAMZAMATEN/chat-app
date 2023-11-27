import 'package:chat_app/res/colors/color.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room',style: TextStyle(color: Colors.white,
            fontSize: 25, fontWeight: FontWeight.bold),),
        backgroundColor:AppColors.primaryColor,
      ),
      body: Center(
        child:Text('HOME PAGE'),),

      );
  }
}
