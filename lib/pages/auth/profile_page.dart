import 'package:chat_app/pages/HomeScreen/home.dart';
import 'package:flutter/material.dart';

import '../../res/colors/color.dart';
import '../../res/components/navigate_function.dart';
import '../../services/auth_service.dart';
import 'login.dart';
class ProfilePage extends StatefulWidget {
  String userName;
  String email;
 ProfilePage({Key? key ,required this.userName,required this.email}):super(key:key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService =AuthService();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('Profile',style: TextStyle(color: Colors.white,
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
              Text(widget.userName,textAlign: TextAlign.center,style: TextStyle(color:AppColors.primaryColor,
                  fontSize: 25, fontWeight: FontWeight.bold),),
              const SizedBox(height: 15,),
              const Divider(
                height: 2,
              ),
              ListTile(
                onTap: (){
                  nextScreenReplacement(context, HomePage());
                },
                selectedColor: AppColors.primaryColor,
                selected: true,
                contentPadding: EdgeInsets.symmetric(vertical:5,horizontal: 20),
                leading: const Icon(Icons.group),
                title: Text("Groups",style: TextStyle(color:Colors.black,
                    fontSize:17,
                    fontWeight: FontWeight.bold),),
              ),
              ListTile(
                onTap: (){},
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
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 170,horizontal: 40),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Icon(Icons.account_circle,
            size: 200,
            color: Colors.grey.shade700,),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Full Name",style: TextStyle(fontSize: 17,),),
                Text(widget.userName,style: TextStyle(fontSize: 20 ,),),
              ],),
            const Divider(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Email",style: TextStyle(fontSize: 17,),),
                Text(widget.email,style: TextStyle(fontSize: 20 ,),),
              ],),




          ]
        ),
      ),
    );


  }
}
