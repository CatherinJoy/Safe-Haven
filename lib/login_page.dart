// ignore_for_file: unused_import
//ignore_for_file:prefer_const_constructor
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:miniproject/auth_controller.dart';
import 'package:miniproject/sign_up.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailCotroller = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    // ignore: non_constant_identifier_names
    /*outlineInputBorder = OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    );*/
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 246, 229, 234),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  width: w,
                  height: h * 0.3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("img/Safehaven.png"),
                          fit: BoxFit.cover))),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Sign into your account",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 63, 62, 62)),
                      ),
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
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
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
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
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
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            "Forgot password?",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 63, 62, 62)),
                          ),
                        ],
                      )
                    ],
                  )),
              SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  /*AuthController.instance.login(emailCotroller.text.trim(),
                      passwordController.text.trim());*/
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
                      "Sign in",
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
                height: w * 0.1,
              ),
              RichText(
                  text: TextSpan(
                      text: "Don\'t have an account?",
                      style: TextStyle(
                          color: Color.fromARGB(255, 70, 66, 66), fontSize: 15),
                      children: [
                    TextSpan(
                        text: " Create",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => SignUpPage()))
                  ]))
            ],
          ),
        ));
  }
}
