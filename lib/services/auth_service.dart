

import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
   FirebaseAuth  firebaseAuth=FirebaseAuth.instance;


   //login



//register function
Future registerUserWithEmailAndPassword(String fullName,String email,String password) async{
     try{User user=(await firebaseAuth.createUserWithEmailAndPassword( email:email,password:password)).user!;
     if(User!=null){//call our database to update user data
       return true ; }
     }on FirebaseAuthException catch(e) {
 print(e);
}

}
//sign out
}