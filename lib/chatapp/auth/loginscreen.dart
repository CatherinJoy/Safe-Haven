//import 'dart:js';
//import 'dart:math';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:miniproject/chatapp/helper/dialogs.dart';

import '../../main.dart';
import '../api/apis.dart';
import '../screens/chathome.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({super.key});
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

Future<bool> checkInternetConnectivity() async {
  try {
    await InternetAddress.lookup('google.com');
    return true; // Internet connection is available
  } catch (e) {
    log('\ncheckInternetConnectivity Error: $e');
    return false; // No internet connection
  }
}

/*_handleGoogleBtnClick(BuildContext context) async {
  //for showing progress bar
  Dialogs.showProgressbar(context);
  bool hasInternet = await checkInternetConnectivity();

  if (hasInternet) {
    signInWithGoogle().then((success) async {
     //for hiding progress bar
      Navigator.pop(context);
      if (success) {
        log('Sign in with Google successful');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const ChatH()));
      } else {
        log('Sign in with Google failed');
        Dialogs.showSnackbar(
            context, 'Something went wrong (Check your internet connectivity)');
      }
    });
  } else {
    log('No internet connection');
    Dialogs.showSnackbar(context, 'No internet connectivity');
  }
}*/
void _handleGoogleBtnClick(BuildContext context) async {
  //for showing progress bar
  Dialogs.showProgressbar(context);
  bool hasInternet = await checkInternetConnectivity();

  if (hasInternet) {
    signInWithGoogle().then((success) async {
      //for hiding progress bar
      Navigator.pop(context);
      if (success) {
        final user = APIs.auth.currentUser;
        if (user != null) {
          log('Sign in with Google successful');
          //await user.reload();
          if ((await APIs.userExists())) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ChatH()),
            );
          } else {
            await APIs.createUser().then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ChatH()),
              );
            });
          }
          ;
        }
      } else {
        log('Sign in with Google failed');
        Dialogs.showSnackbar(
          context,
          'Something went wrong (Check your internet connectivity)',
        );
      }
    });
  } else {
    log('No internet connection');
    Dialogs.showSnackbar(
      context,
      'No internet connectivity',
    );
  }
}

Future<bool> signInWithGoogle() async {
  try {
    await InternetAddress.lookup('google.com');

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return true
    await APIs.auth.signInWithCredential(credential);
    // Sign in with the credential
    final UserCredential userCredential =
        await APIs.auth.signInWithCredential(credential);

    // Fetch additional user information and update display name
    final User? user = userCredential.user;
    if (user != null) {
      // Reload user data to ensure it's up-to-date
      await user.reload();
      log('Sign in with Google successful');
      log('\nUser: ${user.uid}');
      log('\nUser email: ${user.email}');

      // Fetch additional user information and update display name, etc.
      // Example: await APIs.updateUserInfo(user.uid, user.displayName);
      // Replace with your own API calls to update user information

      return true;
    } else {
      log('Sign in with Google failed');
      return false;
    }
    // Fetch user information and update display name
    /*final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
    }*/
    return true;
  } catch (e) {
    log('\nsignInWithGoogle Error: $e');
    return false;
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
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
          Positioned(
            top: mq.height * .55,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, shape: StadiumBorder()),
                onPressed: () {
                  _handleGoogleBtnClick(context);
                },
                icon: Image.asset(
                  "img/Google.png",
                  height: mq.height * .04,
                ),
                label: RichText(
                    text: TextSpan(style: TextStyle(fontSize: 18), children: [
                  TextSpan(text: "Sign In with "),
                  TextSpan(
                      text: "Google",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ]))),
          ),
        ],
      ),
    );
    ;
  }
}
