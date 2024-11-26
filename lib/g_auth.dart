//import 'dart:html';
/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:miniproject/login_page.dart';
import 'package:miniproject/welcome_page.dart';

class GAuth {
  User? user;
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return WelcomePage(
              email: user!.email!,
            );
          } else {
            return const LoginPage();
          }
        });
  }

  signInWithGoogle() async {
    //Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    //Obtain the auth details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //Create new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //Once signed in, return the User Credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //SignOut
  signOut() {
    FirebaseAuth.instance.signOut();
  }
}*/
