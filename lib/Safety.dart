import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:miniproject/E_Contact.dart';
import 'package:miniproject/google_map_page.dart';
import 'package:miniproject/safety_tips.dart';
import 'package:miniproject/self_defense.dart';
import 'package:miniproject/welcome_page.dart';

import 'chatapp/models/chat_user.dart';

class SafetyPage extends StatelessWidget {
  const SafetyPage({Key? key, required this.user}) : super(key: key);

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    //User? user;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 229, 234),
        body: 
        Column(children: [
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
              )
              ),
         
          SizedBox(height: 20,  ),
         
          Expanded(
            child: Container(
              width: w,
              margin: const EdgeInsets.only(left: 10,right: 2),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_right,size: 30,color: Color.fromARGB(255, 139, 18, 148)),
                    FittedBox(
                      fit: BoxFit.fill,
                      child:                       
                         RichText(text: TextSpan(
              text:" Location Tracking",
              style: TextStyle(
                fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color:Color.fromARGB(255, 139, 18, 148)
              ),
              recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>GoogleMapPage())
                )
            ),
                      
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Icon(Icons.arrow_right,size: 30,color:Color.fromARGB(255, 139, 18, 148)),
              RichText(text: TextSpan(
              text:" Self Defense",
              style: TextStyle(
                fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color:Color.fromARGB(255, 139, 18, 148)
              ),
              recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SelfDefensePage())
                )
            ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Icon(Icons.arrow_right,size: 30,color:Color.fromARGB(255, 139, 18, 148)),
              RichText(text: TextSpan(
              text:" Safety Tips",
              style: TextStyle(
                fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color:Color.fromARGB(255, 139, 18, 148)
              ),
              recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SafetyTipsPage())
                )
            ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Icon(Icons.arrow_right,size: 30,color:Color.fromARGB(255, 139, 18, 148)),
                    RichText(text: TextSpan(
              text:" Emergency Contacts",
              style: TextStyle(
                fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color:Color.fromARGB(255, 139, 18, 148)
              ),
              recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>EmergencyContactsPage())
                )
            ),
                  ],
                ),
              ],
            ),
            ),
          ),

          SizedBox(height: 50,),
          Container(
            width: w,
            margin: const EdgeInsets.only(left: 20),
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: 
            [
              Icon(Icons.arrow_right,size: 20,),
              RichText(text: TextSpan(
              text:" Back",
              style: TextStyle(
                fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color:Color.fromARGB(255, 62, 62, 62)
              ),
              recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>WelcomePage(user: user,))
                )
            ),
            ] 
            )
          )
          /*Container(
            width: w,
            margin: const EdgeInsets.only(left: 20),
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.arrow_right,size: 20,),
               TextSpan(
                text:"Back",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color:Color.fromARGB(255, 62, 62, 62)
                ),
                recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>WelcomePage())
              ),
            ],
          ),
          ),*/
/*          Container(
            width: w * 0.4,
            height: h * 0.06,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    image: AssetImage("img/SignIn_backgrd.png"),
                    fit: BoxFit.cover)),
            child: Center(
              child: Text(
                "Sign out",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: w * 0.1,
          ),*/
         
          
        ]
        )
    );
  }
}