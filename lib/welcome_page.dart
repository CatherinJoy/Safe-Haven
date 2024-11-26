import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:miniproject/hompepage.dart';
// import 'package:miniproject/auth_controller.dart';
import 'Safety.dart';
import 'Wellness.dart';
import 'chatapp/api/apis.dart';
import 'chatapp/helper/dialogs.dart';
import 'chatapp/models/chat_user.dart';
import 'login_page.dart';
import 'hompepage.dart';

class WelcomePage extends StatefulWidget {
  final ChatUser user;
  const WelcomePage({Key? key, required this.user}) : super(key: key);
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
// required this.email});
  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
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
                Text("Welcome!",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 62, 62, 62))),
                Text(
                  widget.user.email,
                  //'abc.gmail.com',
                  style: const TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SafetyPage(user: widget.user),
                      ));
                },
                child: 
                Expanded(
                  child: Container(
                    width: w * 0.45,
                    height: h * 0.2,
                    margin: EdgeInsets.only(left: 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: AssetImage("img/SignIn_backgrd.png"),
                            fit: BoxFit.cover)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // InkWell(
                          /* onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SafetyPage(user: widget.user),
                                ),
                              );
                            },*/
                          //child:
                          Expanded(
                            child: Container(
                              child: Text(
                                "Your Safety",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          // ),
                        ]),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  //recognizer:
                  /*TapGestureRecognizer()
                    ..onTap = () => Get.to(() => WellnessPage(
                          user: widget.user,
                        ));*/
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WellnessPage(user: widget.user),
                    ),
                  );
                },
                child: 
                Expanded(
                  child: Container(
                    width: w * 0.45,
                    height: h * 0.2,
                    margin: EdgeInsets.only(right: 1, left: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: AssetImage("img/SignIn_backgrd.png"),
                            fit: BoxFit.cover)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Expanded(
                              child: Text(
                                "Your Wellness",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
          /*Container(
            width: w*0.4,
            height: h*0.1,
            margin: EdgeInsets.only(left:1,right: 200),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    image: AssetImage("img/SignIn_backgrd.png"),
                    fit: BoxFit.cover)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Container(
                  child: 
                    Text(
                    "Your Safety",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ]
            ),
          ),*/
          SizedBox(
            width: 350,
          ),
/*          Container(
            width: w*0.4,
            height: h*0.1,
            margin: EdgeInsets.only(left:160,right: 1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    image: AssetImage("img/SignIn_backgrd.png"),
                    fit: BoxFit.cover)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Text(
                "Your Wellness",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),]
            ),
          ), */

          SizedBox(
            height: 60,
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: GestureDetector(
                onTap: () {
                  /*AuthController.instance.logout();*/
                },
                child: InkWell(
                  onTap: () async {
                    //for showing progress dialog
                    Dialogs.showProgressbar(context);

                    await APIs.updateActiveStatus(false);

                    //sign out
                    await APIs.auth.signOut().then((value) async {
                      await GoogleSignIn().signOut().then((value) {
                        //for hiding progress dialog
                        Navigator.pop(context);

                        //to prevent storing old data
                        APIs.auth = FirebaseAuth.instance;

                        //replacing home screen with home page
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HomePage(user: widget.user),
                            ));
                      });
                    });
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
                        "Sign out",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ]));
  }
}
