import 'package:flutter/material.dart';
void nextScreen(context, page){
  Navigator.push(context,MaterialPageRoute(builder: (context)=>page));
}

void nextScreenReplacement(context, page){
  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>page));
}