import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniproject/chatapp/helper/date_util.dart';
import 'package:miniproject/chatapp/models/chat_user.dart';

import '../../main.dart';
import '../widgets/chatuserCard.dart';
import '../api/apis.dart';
import '../auth/loginscreen.dart';
import '../helper/dialogs.dart';

class ViewProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ViewProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
    
  }


  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(widget.user.name),
          ),

          floatingActionButton: Row(
                  mainAxisAlignment:  MainAxisAlignment.center,
                   children: [
                    Text('Joined on: ', style: TextStyle(color: Colors.black87, 
                    fontWeight: FontWeight.w500,
                    fontSize: 16),),
                     Text(
                        MyDateUtil.getLastMessageTime(context: context, time: widget.user.createdAt,showYear: true),
                        style:
                            const TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                   ],
                 ), 
          
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .1),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //adding space
                  SizedBox(
                    width: mq.width,
                    height: mq.height * .03,
                  ),
                  ClipRRect(
                      borderRadius:
                          BorderRadius.circular(mq.height * .3),
                      child: CachedNetworkImage(
                          width: mq.height * .15,
                          height: mq.height * .15,
                          fit: BoxFit.fill,
                          imageUrl: widget.user.image,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                child: Icon(CupertinoIcons.person),
                              ))),
                  SizedBox(
                    width: mq.width,
                    height: mq.height * .03,
                  ),

                  Text(
                    widget.user.email,
                    style:
                        const TextStyle(color: Colors.black87, fontSize: 16),
                  ),

                  SizedBox(
                    width: mq.width,
                    height: mq.height * .02,
                  ),

                 Row(
                  mainAxisAlignment:  MainAxisAlignment.center,
                   children: [
                    Text('About: ', style: TextStyle(color: Colors.black87, 
                    fontWeight: FontWeight.w500,
                    fontSize: 16),),
                     Text(
                        widget.user.about,
                        style:
                            const TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                   ],
                 ), 
                  
                ],
              ),
            ),
          )),
    );
  }

  
}
