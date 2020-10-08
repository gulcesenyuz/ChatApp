import 'package:flutter/material.dart';
import 'package:newrole/widgets/widget.dart';

import '../colors.dart';

class SignIn extends StatefulWidget{
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState  extends State <SignIn> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView (
        child: Container(
          height: MediaQuery.of(context).size.height-90,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: simpleTextFieldStyle(),
                  decoration: textFieldInputDecoration('email')
                ),
                TextField(
                  decoration: textFieldInputDecoration('password'),
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
                  child: Text('Sign In',style: TextStyle(
                    color: Colors.white,
                    fontSize:17
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
                    Text(' Register now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:17,
                        decoration: TextDecoration.underline

                    ),),
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

}

