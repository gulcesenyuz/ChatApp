import 'package:flutter/material.dart';
import 'package:newrole/helper/constants.dart';
import 'package:newrole/services/database.dart';
import 'package:newrole/widgets/widget.dart';

import '../colors.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);


  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods=new DatabaseMethods();
  TextEditingController messageController=new TextEditingController();
  Stream chatMessagesStream;

  Widget ChatMessageList(BuildContext context){
    return StreamBuilder(
      stream: chatMessagesStream,
        builder: (context,snapshot){
        return snapshot.hasData ?ListView.builder(
          itemCount:snapshot.data.documents.length,
            itemBuilder:(context, index){
            return  MessageTile(snapshot.data.documents[index].data()["message"],
                snapshot.data.documents[index].data()["sendBy"]==Constants.myName);
            }): Container(
        );
        }
    );

  }

  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String, dynamic> messageMap={
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap );
      messageController.text="";
    }
    }
    @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
          setState(() {
            chatMessagesStream=value;
          });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, colorD),
      body:Container(
        color: colorC,
        child: Stack(
          children: [
            ChatMessageList(context),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: colorD,
                 padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: messageController,
                          style: TextStyle(
                         color: Colors.white70
                          ),
                          decoration: InputDecoration(
                            hintText: "Message...",
                            hintStyle: TextStyle(
                              color: Colors.white54,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                    ),
                   Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: colorD,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        padding: EdgeInsets.all(6),
                        child: IconButton(
                          padding: EdgeInsets.all(2),
                          icon: Icon(Icons.send, color: Colors.white70,),
                          onPressed: (){
                            sendMessage();
                          },
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ) ,
    );
  }
}

    class MessageTile extends StatelessWidget {
       final String message;
       final bool isSendByMe;
       MessageTile(this.message, this.isSendByMe);


      @override
      Widget build(BuildContext context) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
          width: MediaQuery.of(context).size.width,
          alignment: isSendByMe ? Alignment.centerRight: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isSendByMe ? [
                  const Color(0xffa8675a),
                  const Color (0xff955c50),
                ]
                    :[
                  const Color (0xff955c50),
                  const Color(0xffa8675a),
                ]
              ),
              borderRadius: isSendByMe?
                  BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ):
              BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
            ),
            child: Text(message, style:TextStyle(
              color: Colors.white,
                  fontSize: 17
            ),),
          ),
        );
      }
    }
    