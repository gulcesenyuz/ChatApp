import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newrole/helper/helperfunctions.dart';
import 'package:newrole/services/auth.dart';
import 'package:newrole/services/database.dart';
import 'package:newrole/widgets/widget.dart';

import '../colors.dart';
import 'chatRoomsScreen.dart';

class SignIn extends StatefulWidget{

  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState  extends State <SignIn> {
  final formKey=GlobalKey<FormState>();
  DatabaseMethods databaseMethods=new DatabaseMethods();
  QuerySnapshot snapshotUserInfo;
  AuthMethods authMethods=new AuthMethods();
  TextEditingController emailTextEditingController= new TextEditingController();
  TextEditingController passwordTextEditingController= new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, colorA),
      body: SingleChildScrollView (
        child: Container(
          height: MediaQuery.of(context).size.height-90,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(children: [
                    TextFormField(
                        validator: (val){
                          return RegExp(
                              r"(:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*)@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])")
                              .hasMatch(val)? null:'please provide a valid email';
                        },
                        controller: emailTextEditingController,
                        style: simpleTextFieldStyle(),
                        decoration: textFieldInputDecoration('email')
                    ),
                    TextFormField(
                      validator: (val){
                        return val.length>6? null: 'the password should contain minimum 6 characters';
                      },
                      controller: passwordTextEditingController,
                      decoration: textFieldInputDecoration('password'),
                      obscureText: true,
                    ),
                  ],),
                ),
                SizedBox(height: 15,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child:
                    Text('Forgot Password?',
                      style: simpleTextFieldStyle(),),
                  ),
                ),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,// device a göre size ayarlama
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                        colors: [
                          colorB,colorA,colorB
                        ],
                      )
                    ),
                    child: Text('Sign In',style: TextStyle(
                      color: Colors.white,
                      fontSize:17
                    ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,// device a göre size ayarlama
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                        colors: [
                          colorB,colorA,colorB
                        ],
                      )
                  ),
                  child: Text('Sign in with Google',style: TextStyle(
                      color: Colors.white,
                      fontSize:17
                  ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: TextStyle(
                        color: Colors.white,
                        fontSize:17
                    ),),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                    },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(' Register now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:17,
                            decoration: TextDecoration.underline

                        ),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),

              ],
            ),
          ),
        ),
      ),

    );
  }
  bool isLoading=false;
  signIn() {
       if(formKey.currentState.validate()){
          HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
          //HelperFunctions.saveUserEmailSharedPreference(userNameTextEditingController.text);setState(() {

          databaseMethods.getUserByUserEmail(emailTextEditingController.text)
              .then((value){
            snapshotUserInfo=value;
            HelperFunctions
                .saveUserNameSharedPreference(snapshotUserInfo.docs[0].data()["name"]);
            print("${snapshotUserInfo.docs[0].data()["name"]}");

          });

          setState(() {
          isLoading=true;
         });

         authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text)
          .then((value) {

        if(value !=null){
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=> ChatRoom()
          ));
        }
         });

          HelperFunctions.saveUserLoggedInSharedPreference(true);

      }
  }
}

