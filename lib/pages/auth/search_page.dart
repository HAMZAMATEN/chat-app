import "package:chat_app/Helper/helper_function.dart";
import "package:chat_app/pages/auth/chat_page.dart";
import "package:chat_app/res/components/navigate_function.dart";
import "package:chat_app/res/components/snackbar.dart";
import "package:chat_app/services/database_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import"package:flutter/material.dart";
import "package:get/get.dart";

import "../../res/colors/color.dart";
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  QuerySnapshot?searchSnapshot;
  bool hasUserSearched = false;
  String userName = "";
  User ? user;
  bool isJoined = false;

  @override
  void initState() {
    // TODO: implement initState
    getCurrentUserIdAndName();
    super.initState();
  }

  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }
  String getId(String res){
    return res.substring(0,res.indexOf("_"));
  }

  getCurrentUserIdAndName() async {
    HelperFunction.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Search", style: TextStyle(color: Colors.white,
            fontSize: 27, fontWeight: FontWeight.bold),),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              color: AppColors.primaryColor,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search groups...",
                        hintStyle: TextStyle(fontSize: 16, color: Colors.white),

                      ),
                    ),

                  ),
                  GestureDetector(
                    onTap: () {
                      initiateSearchMethod();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(40)),
                      child: Icon(Icons.search, color: Colors.white,),

                    ),
                  ),
                ],
              ),
            ),
            isLoading ? Center(child: CircularProgressIndicator(
              color: AppColors.primaryColor,),
            )
                : groupList(),


          ],
      ),

    );
  }

  initiateSearchMethod() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await DatabaseService()
          .searchByName(searchController.text)
          .then((
          snapshot) {
        setState(() {
          searchSnapshot = snapshot;
          isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }
    groupList() {
     return  hasUserSearched ? ListView.builder(
          shrinkWrap: true,
          itemCount: searchSnapshot!.docs.length,
          itemBuilder: (context, index) {
            return groupTile(
              userName,
              searchSnapshot!.docs[index]['groupId'],
              searchSnapshot!.docs[index]['groupName'],
              searchSnapshot!.docs[index]['admin'],
            );
          }
      )
          : Container();
    }
    joinedOrNot(String userName, String groupId, String groupName,
        String admin) async {
      await DatabaseService(uid: user!.uid).isUserJoined(
          groupId, groupName, userName).then((value) {
        setState(() {
          isJoined = value;
        });
      });
    }


    Widget groupTile(String userName, String groupId, String groupName,
        String admin) {
      //functions to check whether user already exist or not
      joinedOrNot(userName, groupId, groupName, admin);
      return ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor:AppColors.primaryColor,
         child: Text(groupName.substring(0,1).toUpperCase(),style:
           TextStyle(color: Colors.white),),
        ),
        title: Text(groupName,style: TextStyle(fontWeight: FontWeight.w600 ,fontSize: 20),),
        subtitle: Text("Admin:${getName(admin)}",style:TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
      trailing: InkWell(
        onTap:() async {
          await DatabaseService(uid: user!.uid).toggleGroupJoin(groupId, groupName, userName);
          if(isJoined){
            setState(() {
              isJoined=!isJoined;
            });
            showSnackBar(context, Colors.green, "Successfully joined the group");
            Future.delayed(Duration(seconds: 2),(){
              nextScreen(context, ChatPage(groupId: groupId, groupName: groupName, userName: userName));
            });
          }else{
            setState(() {
              isJoined=!isJoined;
              showSnackBar(context, Colors.redAccent, "left the group $groupName");

            });
          }
        },
        child:  isJoined ? Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.8),
            border: Border.all(color: Colors.white,width: 1),
          ),
          padding: EdgeInsets.symmetric(horizontal:20,vertical: 10 ),
          child: Text("Joined",style: TextStyle(color:Colors.white,
           fontWeight: FontWeight.w600 ,fontSize: 16),),
        )
:Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:AppColors.primaryColor,
          ),
          padding: EdgeInsets.symmetric(horizontal:20,vertical: 10 ),
          child: Text("Join Now",style: TextStyle(color: Colors.white),),
      ),
      ),
      );
   }
 }

