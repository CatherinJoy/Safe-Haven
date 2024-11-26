import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miniproject/chatapp/auth/loginscreen.dart';

import '../../main.dart';
import '../api/apis.dart';
import '../screens/chathome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 5000), () {
      //exit full screen
      /*SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.pink));*/

      if (APIs.auth.currentUser != null) {
        log('\nUser: ${APIs.auth.currentUser}');
        log('\nUser Additional Info: ${APIs.auth.currentUser}');
        //navigate to ChatHome
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const ChatH()));
      } else {
        //navigate to loginscreen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }

      /*navigate to loginscreen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));*/
    });
  }

  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Welcome to SafeHavenChat"),
      ),
      body: Stack(
        children: [
          Positioned(
              top: mq.height * .15,
              left: mq.width * .25,
              width: mq.width * .5,
              child: Image.asset("img/s_logo.png")),
          //google login
          Positioned(
            top: mq.height * .55,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child: const Text(
              'Purpose for your well being 🦸‍♀️',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: Colors.deepPurple,
                letterSpacing: .2,
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
