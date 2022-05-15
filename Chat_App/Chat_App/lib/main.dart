//@dart=2.9
import 'package:chat_app/Screens/registerationScreen.dart';
import 'package:flutter/material.dart';
import 'Screens/SigninScreen.dart';
import 'Screens/chat_screen.dart';
import 'Screens/hello_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      //home:const Registerationscreen(),
        initialRoute: _auth.currentUser!=null?Chatscreen.screenRoute:HelloScreen.screenRoute,
        routes: {
          HelloScreen.screenRoute: (context) => HelloScreen(),
          SignInScreen.screenRoute: (context) => SignInScreen(),
          Registerationscreen.screenRoute: (context) => Registerationscreen(),
          Chatscreen.screenRoute: (context) => Chatscreen(),
        }
    );
  }
}


