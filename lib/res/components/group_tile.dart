import 'package:chat_app/res/components/navigate_function.dart';
import 'package:flutter/material.dart';

import '../../pages/auth/chat_page.dart';
import '../colors/color.dart';
class GroupTile extends StatefulWidget {
  String userName;
  String groupId;
  String groupName;
  GroupTile({Key?key ,
    required this.userName,
    required this.groupId,
    required this.groupName})
      :super(key:key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        nextScreen(context, ChatPage(
          groupId: widget.groupId,
          groupName: widget.groupName,
          userName: widget.userName,
        ));
      },
      child: Container(
      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryColor,
            child: Text(widget.groupName.substring(0,1).toUpperCase(),
                textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
          ),
        title: Text(widget.groupName,
          style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
          subtitle: Text("join the conversation as ${widget.userName}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),

      ),
      ),
    );
  }
}
