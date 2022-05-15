import 'package:chat_app/widgets/MYBUtton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_screen.dart';
import 'hello_screen.dart';
class Registerationscreen extends StatefulWidget {
  static const String screenRoute = 'registerationScreen';
  const Registerationscreen({Key? key}) : super(key: key);

  @override
  State<Registerationscreen> createState() => _RegisterationscreenState();
}

class _RegisterationscreenState extends State<Registerationscreen> {
  final _auth=FirebaseAuth.instance;

  late String email;
  late String password;
  bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall:showSpinner ,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

            Container(
              height: 180,
              child: Image.asset('images/logo.png'),

            ),
              SizedBox(height: 50,),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign:TextAlign.center ,
                onChanged: (value){
                  email=value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                  horizontal: 20
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10),
                    ),
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width:1 ),
                    borderRadius: BorderRadius.all(Radius.circular(10),
                    ),
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]!,
                        width:2 ),
                    borderRadius: BorderRadius.all(Radius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height:8 ,),
              TextField(

                obscureText:true ,
                textAlign:TextAlign.center ,
                onChanged: (value){
                  password=value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Password',
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10),
                    ),
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                        width:1 ),
                    borderRadius: BorderRadius.all(Radius.circular(10),
                    ),
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]!,
                        width:2 ),
                    borderRadius: BorderRadius.all(Radius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              MYButton(color: Colors.lightBlue[800]!, title: 'register',
                  onPressed: ()async{
                setState(() {
                  showSpinner=true;
                });
                try{
                  final newUser= await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);

                  Navigator.pushNamed(context, Chatscreen.screenRoute);
                  setState(() {
                    showSpinner=false;
                  });
                }
                catch(e){
                  print(e);
                }

              }),
              MYButton(color: Colors.lightBlue[800]!,
                  title: 'BACK',
                  onPressed: ()async{
                    setState(() {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HelloScreen()));
                    });




                  })

          ],),
        ),
      ),
    );
  }
}