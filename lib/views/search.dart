import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newrole/helper/constants.dart';
import 'package:newrole/services/database.dart';
import 'package:newrole/widgets/widget.dart';

import '../colors.dart';
import 'conversation_screen.dart';
//  33.10 sn
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods= new DatabaseMethods();
  TextEditingController searchTextEditingController =new TextEditingController();

    QuerySnapshot searchSnapshot;
  Widget searchList(){
    return searchSnapshot != null ? ListView.builder( //twk sütunlu liste
        itemCount:searchSnapshot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return searchTile(
            userName: searchSnapshot.docs[index].data()["name"],
            userEmail:searchSnapshot.docs[index].data()["email"],
          );
        }): Container();
  }


  initiateSearch(){
    databaseMethods.getUserByUsername(searchTextEditingController.text)
        .then((val){
          setState(() {
            searchSnapshot=val;
          });
        });
  }
  getChatRoomId(String a, String b){
    return "$a\_$b";
    //if(a.substring(0,1).codeUnitAt(0)> b.substring(0,1).codeUnitAt(0)){
    //  return "$b\_$a";
    //}else{
     // return "$a\_$b";
    //}
  }

  createChatroomAndStartConversation({ String userName}){
    print("${Constants.myName}");

  if(userName != Constants.myName){
    String chatRoomId =getChatRoomId(userName, Constants.myName);
   // print('test123321');
    print(chatRoomId);
    List<String> users= [userName, Constants.myName];
    Map<String, dynamic> chatRoomMap={
      "users":users,
      "chatroomId":chatRoomId,
    };
    DatabaseMethods().createChatRoom(chatRoomId,chatRoomMap);
    Navigator.push(context, MaterialPageRoute(
        builder: (context)=> ConversationScreen(chatRoomId)
    ));
  }else{
    print("you should be very lonely to "
        "send a message to someone except yourself");
  }
  }

  Widget searchTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Text(userName, style: simpleTextFieldStyle(),),
              Text(userEmail, style: simpleTextFieldStyle(),)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap:(){
              createChatroomAndStartConversation(
                  userName: userName
              );
          },

            child: Container(
              decoration: BoxDecoration(
                  color: colorD,
                  borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal:16,vertical: 8 ),
              child: Text("Message",),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context , colorA),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child:TextField(
                        controller: searchTextEditingController,
                          style: TextStyle(
                          color: Colors.white70
                      ),
                          decoration:InputDecoration(
                            hintText: "search contact...",
                            hintStyle: TextStyle(
                              color: Colors.white24
                            ),
                            border: InputBorder.none,
                          )

                      ) ),
                  Container(
                    child: IconButton(
                        padding: EdgeInsets.all(16),
                        icon: Icon(Icons.search, color: Colors.white24,),
                      onPressed: (){
                        initiateSearch();
                      },
                    ),

                  ),
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}


