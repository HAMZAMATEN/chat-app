import 'package:chat_app/Helper/helper_function.dart';
import 'package:chat_app/pages/auth/login.dart';
import 'package:chat_app/pages/auth/profile_page.dart';
import 'package:chat_app/res/colors/color.dart';
import 'package:chat_app/res/components/group_tile.dart';
import 'package:chat_app/res/components/navigate_function.dart';
import 'package:chat_app/res/components/snackbar.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/search_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName="";
  String email="";
  AuthService authService=AuthService();
  Stream? groups;
  bool _isLoading=false;
  String groupName="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
  }
  //string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }
   String getName(String res){
     return res.substring(res.indexOf("_")+1);
   }

  gettingUserData()async{
    await HelperFunction.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
      await HelperFunction.getUserEmailFromSF().then((val) {
        setState(() {
          email = val!;
        });
      });
     // getting the list of snapshots in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).
    getUserGroups().then((snapshot){
      setState(() {
       groups= snapshot;
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
              nextScreen(context, SearchPage());
              }, icon: Icon(Icons.search,color: Colors.white,),),
        ],
        elevation: 0,
        centerTitle: true,
        title: Text('Groups',style: TextStyle(color: Colors.white,
            fontSize: 27, fontWeight: FontWeight.bold),),
        backgroundColor:AppColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 50),
          children: [
            Icon(Icons.account_circle,
          color: Colors.grey,
          size:150 ,
            ),
            const SizedBox(height: 15,),
            Text(userName,textAlign: TextAlign.center,style: TextStyle(color:AppColors.primaryColor,
                fontSize: 25, fontWeight: FontWeight.bold),),
            const SizedBox(height: 15,),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: (){},
              selectedColor: AppColors.primaryColor,
              selected: true,
              contentPadding: EdgeInsets.symmetric(vertical:5,horizontal: 20),
              leading: const Icon(Icons.group),
              title: Text("Groups",style: TextStyle(color:Colors.black,
                  fontSize:17,
                  fontWeight: FontWeight.bold),),
            ),
            ListTile(
              onTap: (){
                nextScreen(context,ProfilePage(userName:userName,email:email));
              },
              selectedColor: AppColors.primaryColor,
              selected: true,
              contentPadding: EdgeInsets.symmetric(vertical:5,horizontal: 20),
              leading: const Icon(Icons.person),
              title: Text("Profile",style: TextStyle(color:Colors.black,
                  fontSize:17,
                  fontWeight: FontWeight.bold),),
            ),
            ListTile(
              onTap: ()async {
                showDialog(
                  barrierDismissible: false,
                  context: context, builder: (context) {
         return AlertDialog(
    title: Text("Logout"),
    content: Text("Are you sure you want to logout?"),
    actions: [
       IconButton(
    onPressed: () {
      Navigator.pop(context);
      },
    icon: Icon(Icons.cancel,
    color: Colors.redAccent,)
    ),
    IconButton(onPressed: () async {
      await authService.signOut();
    Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
    builder: (context) => LoginPage()), (
    route) => false);
    },
    icon: Icon(Icons.done, color: Colors.green,),),

    ],
    );
    },
                );
              },
                  selectedColor:AppColors.primaryColor,
                  selected:true,
                  contentPadding:EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  leading:const Icon(Icons.exit_to_app),
                  title:Text("Logout", style: TextStyle(color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),),
                ),

            ]),

      ),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          popUpDialog(context);},
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add,
          color: Colors.white,
            size: 30,
        ),
      ),
    );


  }
  popUpDialog(BuildContext context){
    showDialog(
    barrierDismissible:false,
        context: context,
        builder:(context) {
          return StatefulBuilder(
              builder: (BuildContext context, setState) {
                return AlertDialog(
                  title: Text("Create a group", textAlign: TextAlign.left,),
                  content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _isLoading == true ? Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor),)
                            : TextField(
                          onChanged: (val) {
                            setState(() {
                              groupName = val;
                            });
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors
                                  .primaryColor,),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors
                                  .primaryColor,),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ]
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        child: Text(
                          "CANCEL", style: TextStyle(color: Colors.white),)),

                    ElevatedButton(
                        onPressed: () async {
                          if (groupName != "") {
                            setState(() {
                              _isLoading = true;
                            });
                            DatabaseService(uid: FirebaseAuth.instance
                                .currentUser!
                                .uid).
                            createGroup(
                                userName,
                                FirebaseAuth.instance.currentUser!.uid,
                                groupName).
                            whenComplete(() {
                              _isLoading = false;
                            });
                            Navigator.pop(context);
                            showSnackBar(context, Colors.green,
                                "Group created successfully.");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        child: Text(
                          "CREATE", style: TextStyle(color: Colors.white),)),
                  ],
                );
              });
        });


  }
  groupList(){
    return StreamBuilder(
      stream: groups,
      builder: (context ,AsyncSnapshot snapshot){
        //make some checks
        if(snapshot.hasData){
          if(snapshot.data['groups']!=null){
            if(snapshot.data['groups'].length!=0){
              return ListView.builder(
                itemCount: snapshot.data['groups'].length,
                  itemBuilder: (context,index){
                  int reverseIndex=snapshot.data['groups'].length - index-1;
                return GroupTile(
                    groupId: getId(snapshot.data['groups'][reverseIndex]),
                    groupName: getName(snapshot.data['groups'][reverseIndex]),
                     userName: snapshot.data['fullName'],);
                  },);

            }else{
              return noGroupWidget();
            }
          }else{
            return noGroupWidget();
          }
       }else{
          return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
        }
    }

    );
  }
  noGroupWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
            popUpDialog(context);
            },
              child: Icon(Icons.add_circle,size: 75,color: Colors.grey.shade600,)),
              SizedBox(height: 20,),
              const Text("you 've not joined any groups , tap"
                  " on the add icon to create a group or also search from top search button",
                textAlign: TextAlign.center,),
            ],
          ),
    );

  }

}
