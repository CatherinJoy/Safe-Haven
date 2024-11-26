import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:miniproject/register_page.dart';
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

class _HomePageState extends State<HomePage> {
  bool userExists = false;
  late ChatUser user; // Define a local variable

 @override
  void initState() {
    super.initState();
    // Check the user's authentication status on initialization
    //APIs.checkAuthentication();
    user = widget.user; // Assign the value of widget.user to user

    // Check if the user has registered when the HomePage is initialized
   // checkRegistrationStatus();
  }

 /* Future<void> checkRegistrationStatus() async {
  // Check if the user has registered
  bool isRegistered = await APIs.isRegistered(user.id);

  if (isRegistered) {
    // User has registered, navigate to WelcomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => WelcomePage(user: widget.user)),
    );
  } else {
    // User has not completed the registration process, navigate to RegisterPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => RegisterPage(user: widget.user)),
    );
  }
}*/

 void _handleGoogleBtnClick(BuildContext context) async {
  // Show progress indicator
  Dialogs.showProgressbar(context);

  bool hasInternet = await checkInternetConnectivity();

  if (hasInternet) {
    bool success = await signInWithGoogle();

    // Hide progress indicator
    Navigator.pop(context);

    if (success) {
      final user = APIs.auth.currentUser;
      if (user != null) {
        log('Sign in with Google successful');
        // Check if the user has registered
        bool isRegistered = await APIs.isRegistered(user.uid);

        if (isRegistered) {
          // User has registered, navigate to WelcomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => WelcomePage(user: _createChatUser(user))),
          );
        } else {
          // User has not completed the registration process, navigate to RegisterPage
          bool registrationComplete = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RegisterPage(user: _createChatUser(user))),
          );

          // Check if the registration process is complete
          if (registrationComplete == true) {
            // Registration is complete, navigate to WelcomePage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => WelcomePage(user: _createChatUser(user))),
            );
          } else {
            // User did not complete the registration process, handle accordingly
            // You can show a message or take any other action here
          }
        }
      }
    } else {
      log('Sign in with Google failed');
      Dialogs.showSnackbar(
        context,
        'Something went wrong (Check your internet connectivity)',
      );
    }
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
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Sign in with the credential
    final UserCredential userCredential = await APIs.auth.signInWithCredential(credential);

    // Check if the user is successfully signed in
    return userCredential.user != null;
  } catch (e) {
    log('\nsignInWithGoogle Error: $e');
    return false;
  }
}


  @override
  Widget build(BuildContext context) {
// Assign the value of widget.user to user
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
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome to SafeHaven",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
