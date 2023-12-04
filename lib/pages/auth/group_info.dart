import 'package:chat_app/pages/HomeScreen/home.dart';
import 'package:chat_app/res/components/navigate_function.dart';
import 'package:chat_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../res/colors/color.dart';
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
  Stream ? members;

  @override
  void initState() {
    getMembers();
    super.initState();

  }

  getMembers() async{
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).
    getGroupMembers(widget.groupId).then((val) {
      setState(() {
        members = val;
      });
    });
  }

  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }
  String getId(String res){
    return res.substring(0,res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text("Group Info", style: TextStyle(color: Colors.white,
                fontSize: 27, fontWeight: FontWeight.bold),),
            backgroundColor: AppColors.primaryColor,
          actions: [
            IconButton(
                onPressed: () {
    showDialog(
    barrierDismissible: false,
    context: context, builder: (context) {
      return AlertDialog(
        title: Text("Exit"),
        content: Text("Are you sure you exit the group"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel,
                color: Colors.redAccent,)
          ),
          IconButton(
            onPressed: ()async{
              DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).
              toggleGroupJoin(widget.groupId,getName(widget.adminName), widget.groupName).
              whenComplete(() {
                nextScreenReplacement(context,HomePage());
              });

            },
            icon: Icon(Icons.done, color: Colors.green,),),

        ],
      );
    });
    },
    icon: Icon(Icons.exit_to_app, color: Colors.white,)),
        ],
        ),
         body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
              children:[
          Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.primaryColor.withOpacity(0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primaryColor,
                child: Text(widget.groupName.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20,
                  ),),
              ),
              const SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Group: ${widget.groupName}", style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),),
                  SizedBox(height: 10,),
                  Text("Admin: ${getName(widget.adminName)}", style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),)
                ],
              )
            ],
          ),
        ),
                memberList(),

        ],
    ),


    ),

    );
  }

  memberList() {
    return StreamBuilder(
        stream: members,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
          if (snapshot.data["members"] != null) {
            if (snapshot.data["members"]!.length != 0) {
              return ListView.builder(
                  itemCount: snapshot.data["members"].length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.primaryColor,

                          child: Text(getName(snapshot.data['members'][index])
                              .substring(0, 1)
                              .toUpperCase(), style: TextStyle(color: Colors
                              .white, fontSize: 20, fontWeight: FontWeight
                              .w500),),
                        ),
                        title: Text(getName(snapshot.data["members"][index]),style: TextStyle(fontSize: 20, fontWeight: FontWeight
                            .w500),),
                        subtitle: Text(getId(snapshot.data["members"][index],),
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight
                            .w400),),
                      ),


                    );
                  });
            } else {
              return Center(
                child: Text("No member"),
              );
            }
          } else {
            return Center(
              child: Text("No member"),
            );
          }
          } else{
            return Center(child:CircularProgressIndicator(color: AppColors.primaryColor,));
          }


        }
        );
  }
}

