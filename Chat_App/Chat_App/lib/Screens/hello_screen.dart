import 'package:flutter/material.dart';
import 'package:chat_app/widgets/MYBUtton.dart';

import 'SigninScreen.dart';
import 'registerationScreen.dart';
class HelloScreen extends StatefulWidget {
  static const String screenRoute = 'HelloScreen';

  const HelloScreen({Key? key}) : super(key: key);

  @override
  State<HelloScreen> createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset('images/logo.png'),
                ),
                Text(
                  "Chat App",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff2e386b),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            MYButton(
              color: Colors.blue[600]!,
              title: 'Sign in',
              onPressed: () {
                Navigator.pushNamed(context, SignInScreen.screenRoute);
              },
            ),
            MYButton(
                color: Colors.blue[900]!,
                title: 'register',
                onPressed: (){
                  Navigator.pushNamed(context, Registerationscreen.screenRoute);
                }
                ),
          ],
        ),
      ),
    );
  }
}


