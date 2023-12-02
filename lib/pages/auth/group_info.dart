import 'package:flutter/material.dart';
class GroupInfo extends StatefulWidget {
  String groupId;
  String groupName;
  String adminName;
 GroupInfo({Key?key ,
  required this.groupId,
  required this.groupName,
  required this.adminName,
  }):super(key:key);

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
          child:Text(widget.adminName),
     ),
    );
  }
}
