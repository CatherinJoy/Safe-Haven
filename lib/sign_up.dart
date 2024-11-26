import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:miniproject/auth_controller.dart';
import 'package:miniproject/g_auth.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailCotroller = TextEditingController();
    var passwordController = TextEditingController();
    List images = ["G.png", "Facebook.png", "Twitter.png"];

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
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
                        controller: emailCotroller,
                        decoration: InputDecoration(
                          hintText: "Email ID",
                          prefixIcon:
                              Icon(Icons.email, color: Colors.deepPurple),
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
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon:
                              Icon(Icons.lock, color: Colors.deepPurple),
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
                    /* Row(
                  children: [
                    Expanded(child: Container(),),
                    Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontSize: 15,
                      color:Color.fromARGB(255, 63, 62, 62)
                    ),
                  ),
                  ],
                 )
                */
                  ],
                )),
            SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () {
               /* AuthController.instance.register(
                    emailCotroller.text.trim(), passwordController.text.trim());*/
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
                    "Sign up",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.back(),
                    text: "Have an account?",
                    style: TextStyle(fontSize: 20, color: Colors.grey[500]))),
            SizedBox(
              height: w * 0.1,
            ),
            RichText(
                text: TextSpan(
              text: "Sign up using",
              style: TextStyle(
                  color: Color.fromARGB(255, 70, 66, 66), fontSize: 15),
            )),
            GestureDetector(
              onTap: () {
                //GAuth().signInWithGoogle();
              },
              child: const Image(width: 100, image: AssetImage('img/G.png'),),
            )
/*            Wrap(
                children: List<Widget>.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromARGB(255, 66, 8, 77),
                  child: CircleAvatar(
                    backgroundColor: Colors.white10,
                    radius: 25,
                    backgroundImage: AssetImage("img/" + images[index]),
                  ),
                ),
              );
            }))*/
          ]),
        ));
  }
}
