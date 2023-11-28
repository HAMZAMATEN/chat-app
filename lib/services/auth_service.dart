

import 'package:chat_app/Helper/helper_function.dart';
import 'package:chat_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
   FirebaseAuth  firebaseAuth=FirebaseAuth.instance;

   //login
   Future LoginUserWithEmailAndPassword(String email,String password) async{
     try{
       User user=(await firebaseAuth.signInWithEmailAndPassword( email:email,password:password))
           .user!;
       if(user!=null){
         //call our database to update user data
         return true ; }
     }on FirebaseAuthException catch(e) {
       print(e);
       return e.message;
     }

   }



//register function
Future registerUserWithEmailAndPassword(String fullName,String email,String password) async{
     try{
       User user=(await firebaseAuth.createUserWithEmailAndPassword( email:email,password:password))
           .user!;
     if(user!=null){
       //call our database to update user data
      await  DatabaseService(uid: user.uid).savingUserData(fullName, email);
       return true ; }
     }on FirebaseAuthException catch(e) {
 print(e);
 return e.message;
}

}
//sign out
Future signOut() async{
  try {
    await HelperFunction.saveUserLoggedInStatus(false);
    await HelperFunction.saveUserNameSP("");
    await HelperFunction.saveUserEmailSp("");
    await firebaseAuth.signOut();
  }catch(e){
    return null;
  }


}

}