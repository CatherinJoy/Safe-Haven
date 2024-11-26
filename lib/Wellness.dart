import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miniproject/chatapp/screens/splash_screen.dart';
import 'package:miniproject/health_tips.dart';
import 'auth_controller.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:miniproject/welcome_page.dart';

import 'chatapp/models/chat_user.dart';

class WellnessPage extends StatelessWidget {
  const WellnessPage({Key? key, required this.user}) : super(key: key);

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    //User? user;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 229, 234),
        body: Column(children: [
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
            height: 20,
          ),
          Container(
            width: w,
            margin: const EdgeInsets.only(left: 10, right: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_right,
                        size: 30, color: Color.fromARGB(255, 139, 18, 148)),
                    RichText(text: TextSpan(
              text:" Health Tips",
              style: TextStyle(
                fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color:Color.fromARGB(255, 139, 18, 148)
              ),
              recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>HealthTipsPage())
                )
            ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                /*Row(
                children: [
                  Icon(Icons.arrow_right,size: 30,color:Color.fromARGB(255, 139, 18, 148)),
                                Text(
                        "Contact medical professionals",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color:Color.fromARGB(255, 139, 18, 148)
                        )
                      ),

                ],
              ),*/
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const SplashScreen()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_right,
                          size: 30, color: Color.fromARGB(255, 139, 18, 148)),
                      Text("Support group",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 139, 18, 148))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
          ),
          Container(
              width: w,
              margin: const EdgeInsets.only(left: 20),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(
                  Icons.arrow_right,
                  size: 20,
                ),
                
                   RichText(
                      text: TextSpan(
                    text: " Back",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color.fromARGB(255, 62, 62, 62)),
                     recognizer: TapGestureRecognizer()
                       ..onTap = () => Get.to(() => WelcomePage(user: user,))
                  )),
                
              ]))
        ]));
  }
}
