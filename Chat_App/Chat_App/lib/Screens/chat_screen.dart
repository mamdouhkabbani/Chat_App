import 'package:chat_app/Screens/hello_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



final _firestor=FirebaseFirestore.instance;
late User signedInuser;



class Chatscreen extends StatefulWidget {
  static const String screenRoute = 'Chatscreen';

  const Chatscreen({Key? key}) : super(key: key);

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final messageTextController=TextEditingController();
  final _auth=FirebaseAuth.instance;
   String? messegeText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser(){
      try{
        final user=_auth.currentUser;
        if(user!=null) {
          signedInuser = user;
          print(signedInuser.email);
        }
      }
      catch(e){
        print(e);
      }


  }


  /*void  messgaeStreams()async{
    await for(var snapshot in _firestor.collection('messages').snapshots()){
      for(var message in snapshot.docs){
        print(message.data());
      }
    }
  }*/


 /* void getMessages() async {
    final messages = await _firestor.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }*/

























  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false ,
      home: Scaffold(

        appBar: AppBar(
          backgroundColor:Colors.lightBlue[900] ,
          title: Row(
            children: [
              Image.asset("images/logo.png",height: 25,),
              SizedBox(width: 10,),
              Text("Chat"),
            
          ],
          ),
          actions: [
            IconButton(onPressed: (){
              //add here logout function
              //getMessages();
             // messgaeStreams();
              _auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HelloScreen()));
              //Navigator.pop(context);

            }
            , icon: Icon(Icons.close)
            )
          ],




        ),
       body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MessageStreamBuilder(),

              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.orange,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messegeText=value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          hintText: 'Write your message here...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestor.collection('messages').add({
                          'text':messegeText,
                          'sender':signedInuser.email,
                          'time':FieldValue.serverTimestamp()

                        });
                      },
                      child: Text(
                        'send',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestor.collection('messages').orderBy('time').snapshots(),
        builder: (context,snapshot){
          List<MessageLine> messageWidgets=[];

          if(!snapshot.hasData){
            //add hear a spinner
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            );
          }

          final messages=snapshot.data!.docs.reversed;
          for(var message in messages ){
            final messageText= message.get('text');
            final messageSender=message.get('sender');
            final currentUser=signedInuser.email;


            final messageWidget=MessageLine(sender: messageSender,
              text: messageText,
              IAm: currentUser==messageSender,
            );
            messageWidgets.add(messageWidget);



          }



          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              children: messageWidgets,
            ),
          );
        }
    );
  }
}


class MessageLine extends StatelessWidget {
  const MessageLine({this.sender,this.text,required this.IAm, Key? key}) : super(key: key);

  final String? sender;
  final String? text;
  final bool IAm;


  @override
  Widget build(BuildContext context) {
    late String facebook="";
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:IAm? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text('$sender',style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.bold ),),
          Material(
            elevation: 5,
            borderRadius:IAm?BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ) :BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color:IAm? Colors.blue[900]:Colors.grey[500],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child:  Text('$text',
                  style: TextStyle(fontSize: 15,color:IAm?Colors.white:Colors.black ),
                ),





            ),
          ),

        ],
      ),
    );
  }
}

