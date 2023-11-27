import "package:chat_app/res/colors/color.dart";
import "package:chat_app/res/components/register_image.dart";
import"package:flutter/material.dart";

import "../../res/components/registerpage.dart";

    class RegisterPage extends StatefulWidget {
    const RegisterPage({super.key});
    @override
    State<RegisterPage> createState() => _RegisterPageState();
    }
    class _RegisterPageState extends State<RegisterPage> {

        @override
    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
    body: Register().isLoading  ? Center(child:CircularProgressIndicator(color: AppColors.primaryColor,)):SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 80),
    child: Column(
    children:[
    RegisterImage(),
      Register()  ,


    ],




    ),),
    );



    }
    }

