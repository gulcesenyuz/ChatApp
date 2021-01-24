import 'package:flutter/material.dart';
import 'package:newrole/helper/authenticate.dart';
import 'package:newrole/helper/constants.dart';
import 'package:newrole/helper/helperfunctions.dart';
import 'package:newrole/services/auth.dart';
import 'package:newrole/services/database.dart';
import 'package:newrole/views/conversation_screen.dart';
import 'package:newrole/views/search.dart';

import '../colors.dart';

class ChatRoom extends StatefulWidget{
  @override
  _ChatRoomState createState()=> _ChatRoomState();
}


class _ChatRoomState extends State<ChatRoom>{

  AuthMethods authMethods=new AuthMethods();
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatRoomSteam;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomSteam,
        builder: (context, snapshot) {
          return snapshot.hasData ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return ChatRoomTile(
                  snapshot.data.documents[index].data()["chatroomId"]
                      .toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
                );
              }):
              Container(
                child: Text("BOŞ")
              );

        },
    );
  }

  @override
  void initState(){
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName= await HelperFunctions.getUserNameSharedPreference() as String;
    databaseMethods.getChatRooms(Constants.myName).then((value){
      setState(() {
        chatRoomSteam=value;
      });
    });
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: colorA,
        title:Image.asset("assets/images/newrolename.png",
          height: 40,),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=> Authenticate()
                  ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal:16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search, color:Colors.white70,),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=> SearchScreen()
              ));
        },
      ),
    );
  }
}
class ChatRoomTile extends StatelessWidget {
  final String userName;
  //final String chatRoomId;

  ChatRoomTile(this.userName);
  @override
  Widget build(BuildContext context) {
    return
    Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: colorC,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text("${userName[0]}",//upper case ll
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                  fontWeight: FontWeight.w400,
              ),
              ),
            ),
            SizedBox(width: 8,),
            Text(userName, style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic
            ),),
          ],
        ),
      );
  }
}
