import 'package:flutter/material.dart';
import 'package:newrole/colors.dart';
//import 'package:newrole/views/signin.dart';
import 'package:newrole/views/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: colorB,
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home: SignUp(),
    );

  }

}
