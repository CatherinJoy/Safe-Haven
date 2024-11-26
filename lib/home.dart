import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:miniproject/welcome_page.dart';

import 'chatapp/api/apis.dart';
import 'chatapp/helper/dialogs.dart';
import 'chatapp/models/chat_user.dart';
import 'chatapp/screens/chathome.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);

  final ChatUser user;

  @override
  State<HomePage> createState() => _HomePageState();
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
              MaterialPageRoute(builder: (_) =>  WelcomePage(user: _createChatUser(user))),
            );
          } else {
            await APIs.createUser().then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) =>  WelcomePage(user: _createChatUser(user))),
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
ChatUser _createChatUser(User user) {
    return ChatUser(
      image: '', // Provide the necessary image property value
      about: '', // Provide the necessary about property value
      name: user.displayName ?? '',
      createdAt: '', // Provide the necessary createdAt property value
      lastActive: '', // Provide the necessary lastActive property value
      isOnline: false, // Provide the necessary isOnline property value
      id: user.uid,
      email: user.email ?? '',
      pushToken: '', // Provide the necessary pushToken property value
    );
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

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
  mq = MediaQuery.of(context).size;
  return Scaffold(
    body: Column(
      children: [
        Container(
          width: mq.width,
          height: mq.height * 0.3,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("img/SignIn_backgrd.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: mq.height * 0.14,
              ),
              CircleAvatar(
                backgroundColor: Color.fromARGB(255, 239, 221, 233),
                radius: 55,
                backgroundImage: AssetImage("img/s_logo.png"),
              ),
            ],
          ),
        ),
        Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: mq.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello!",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Welcome to SafeHaven",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ])),
        SizedBox(height: mq.height * 0.25),
        SizedBox(
          width: mq.width * 0.9,
          height: mq.height * 0.06,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: StadiumBorder(),
            ),
            onPressed: () {
              _handleGoogleBtnClick(context);
            },
            icon: Image.asset(
              "img/Google.png",
              height: mq.height * 0.04,
            ),
            label: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18),
                children: [
                  TextSpan(text: "Sign In with "),
                  TextSpan(
                    text: "Google",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


}
