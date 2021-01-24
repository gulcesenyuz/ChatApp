

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:newrole/modal/user.dart';

class User{
  String userId;
  User({this.userId});

}
//*****************************************************
class AuthMethods{
//building secure authentication systems
  final FirebaseAuth _auth= FirebaseAuth.instance;

  // ignore: deprecated_member_use
  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null ? User(userId:user.uid ):null;
  }

  Future signInWithEmailAndPassword (String email, String password)async{
    try{
      UserCredential result= await _auth.signInWithEmailAndPassword
        (email: email, password:password);
      // ignore: deprecated_member_use
      FirebaseUser firebaseUser =result.user;
      return _userFromFirebaseUser(firebaseUser);


    }catch(e){
      print(e.toString());

    }
  }

  Future signUpWithEmailAndPassword (String email, String password)async{
    try{
      UserCredential result= await _auth.signInWithEmailAndPassword
        (email: email, password:password);
      // ignore: deprecated_member_use
      FirebaseUser firebaseUser =result.user;
      return _userFromFirebaseUser(firebaseUser);

    }catch(e){
      print(e.toString());
    }
  }

  Future resetPass(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }
    catch(e){
      print(e.toString());
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){

    }
  }

}
