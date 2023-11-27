

import 'package:chat_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
   FirebaseAuth  firebaseAuth=FirebaseAuth.instance;


   //login



//register function
Future registerUserWithEmailAndPassword(String fullName,String email,String password) async{
     try{
       User user=(await firebaseAuth.createUserWithEmailAndPassword( email:email,password:password))
           .user!;
     if(user!=null){
       //call our database to update user data
      await  DatabaseService(uid: user.uid).updateUserData(fullName, email);
       return true ; }
     }on FirebaseAuthException catch(e) {
 print(e);
 return e.message;
}

}
//sign out
}