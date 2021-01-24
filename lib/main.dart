import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newrole/colors.dart';
import 'package:newrole/helper/authenticate.dart';
import 'package:newrole/helper/helperfunctions.dart';
import 'package:newrole/views/chatRoomsScreen.dart';


 Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn=false ;

  @override
  void initState(){
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference()
    .then((value){
      setState(() {
        userIsLoggedIn= value;
      });
    });
  }

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
      home:userIsLoggedIn ? ChatRoom():Authenticate(),

    );

  }
}

