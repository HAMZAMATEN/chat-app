import 'package:chat_app/pages/auth/group_info.dart';
import 'package:chat_app/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../res/colors/color.dart';
import '../../res/components/navigate_function.dart';
class ChatPage extends StatefulWidget {
  String groupId;
  String groupName;
  String userName;
   ChatPage({Key? key,
     required this.groupId,
     required this.groupName,
     required this.userName,
   }):super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot> ? chats;
  String admin="";
  @override
 void initState() {
    // TODO: implement initState
    super.initState();
    getChatAndAdmin();
  }
  getChatAndAdmin(){
    DatabaseService().getChats(widget.groupId).then((val){
      setState((){
        chats=val;
      });
  });
    DatabaseService().getGroupAdmin(widget.groupId).then((val){
      setState((){
       admin=val;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              nextScreen(context, GroupInfo(
                  groupId: widget.groupId,
             groupName: widget.groupName,
                 adminName:admin));
            }, icon: Icon(Icons.info,color: Colors.white,),),
        ],
        elevation: 0,
        centerTitle: true,
        title: Text(widget.groupName,style: TextStyle(color: Colors.white,
            fontSize: 27, fontWeight: FontWeight.bold),),
        backgroundColor:AppColors.primaryColor,
      ),
    );
  }
}
