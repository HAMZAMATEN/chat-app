import 'package:chat_app/Helper/helper_function.dart';
import 'package:chat_app/pages/auth/login.dart';
import 'package:chat_app/pages/auth/profile_page.dart';
import 'package:chat_app/res/colors/color.dart';
import 'package:chat_app/res/components/navigate_function.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName="";
  String email="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
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

  }
  AuthService authService=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
              nextScreen(context, SearchBar());
              }, icon: Icon(Icons.search,color: Colors.white,),),
        ],
        elevation: 0,
        centerTitle: true,
        title: Text('Groups',style: TextStyle(color: Colors.white,
            fontSize: 25, fontWeight: FontWeight.bold),),
        backgroundColor:AppColors.primaryColor,
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
    );


  }
}
