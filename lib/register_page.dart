import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:miniproject/Wellness.dart';
import 'package:miniproject/welcome_page.dart';
import 'chatapp/api/apis.dart';
import 'chatapp/helper/dialogs.dart';
import 'chatapp/models/chat_user.dart';
import 'home.dart';
import 'sign_up.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  final ChatUser user;

  final bool registrationComplete;

  const RegisterPage({Key? key, required this.user, this.registrationComplete = false}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emergencyNameController = TextEditingController();
  final TextEditingController emergencyPhoneNumberController =
      TextEditingController();
  final TextEditingController relationController = TextEditingController();

  void registerUser() async {
    if (nameController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        emergencyNameController.text.isEmpty ||
        emergencyPhoneNumberController.text.isEmpty ||
        relationController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill all the fields'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      // Register user in Firestore
      await FirebaseFirestore.instance
          .collection('Emergency_Contact_Table')
          .add({
        'UserName': nameController.text,
        'UserPhn': phoneNumberController.text,
        'EName': emergencyNameController.text,
        'EPhn': emergencyPhoneNumberController.text,
        'ERelation': relationController.text,
      });

      // Mark user as registered
      await FirebaseFirestore.instance
          .collection('Registered')
          .doc(widget.user.id)
          .set({'registered': true});

      // Navigate to WelcomePage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(user: widget.user),
        ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to register user: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print('Failed to register user: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
   
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 229, 234),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          Container(
              width: w,
              height: h * 0.3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/SignIn_backgrd.png"),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.14,
                  ),
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 239, 221, 233),
                    radius: 55,
                    backgroundImage: AssetImage("img/s_logo.png"),
                  )
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            width: w,
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enter your details",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink)),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2)),
                      ],
                    ),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Your Name",
                        prefixIcon: Icon(Icons.emoji_emotions,
                            color: Colors.deepPurple),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2)),
                      ],
                    ),
                    child: TextField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        hintText: "Your Phone Number",
                        prefixIcon: Icon(Icons.phone, color: Colors.deepPurple),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: w,
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Enter Emergency Contact Info",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2)),
                      ],
                    ),
                    child: TextField(
                      controller: emergencyNameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        prefixIcon: Icon(Icons.emoji_emotions,
                            color: Colors.deepPurple),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2)),
                      ],
                    ),
                    child: TextField(
                      controller: emergencyPhoneNumberController,
                      decoration: InputDecoration(
                        hintText: "Emergency Phone number",
                        prefixIcon: Icon(Icons.contact_emergency,
                            color: Colors.deepPurple),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2)),
                      ],
                    ),
                    child: TextField(
                      controller: relationController,
                      decoration: InputDecoration(
                        hintText: "Relation",
                        prefixIcon: Icon(Icons.group, color: Colors.deepPurple),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 100,
          ),
          InkWell(
            onTap: () {
              registerUser();
        /*      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WellnessPage(user: widget.user),
      ),
    );*/
            },
            child: Container(
              width: w * 0.4,
              height: h * 0.06,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: AssetImage("img/SignIn_backgrd.png"),
                      fit: BoxFit.cover)),
              child: Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),

        ]),
      ),
    /* floatingActionButton: Padding(
  padding: const EdgeInsets.only(bottom: 10),
  child: FloatingActionButton.extended(
    backgroundColor: Colors.red,
    onPressed: () async {
    //for showing progress dialog
                Dialogs.showProgressbar(context);

                await APIs.updateActiveStatus(false);

                //sign out
                await APIs.auth.signOut().then((value) async {
                  await GoogleSignIn().signOut().then((value) {
                    //for hiding progress dialog
                    Navigator.pop(context);

                    //move to homescreen
                    Navigator.pop(context);

                    //to prevent storing old data
                    APIs.auth = FirebaseAuth.instance;

                    //replacing home screen with login screen
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => HomePage(user: widget.user)));
                  });
                });
},
    label: const Text('Logout'),
    icon: const Icon(Icons.logout),
  ),
),
*/
    );
  }
}


     /* Dialogs.showProgressbar(context);

      // Update active status to false
      await APIs.updateActiveStatus(false);

      // Sign out from Firebase Authentication
      await APIs.auth.signOut().then((value) async {
        // Hide progress dialog
        Navigator.pop(context);

        // Move to the home screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage(user: widget.user)),
          (route) => false, // Remove all previous routes from the stack
        );
      }).catchError((error) {
        // Handle sign-out error
        log('Failed to sign out: $error');
      });*/
