import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:miniproject/chatapp/models/chat_user.dart';
import 'package:miniproject/chatapp/screens/profile_screen.dart';

import '../../main.dart';
import '../../welcome_page.dart';
import '../widgets/chatuserCard.dart';
import '../api/apis.dart';

class ChatH extends StatefulWidget {
  const ChatH({super.key});

  @override
  State<ChatH> createState() => _ChatHState();
}

class _ChatHState extends State<ChatH> {
  List<ChatUser> _list = [];
  final List<ChatUser> _searchList = [];
  bool _isSearching = false;
 ChatUser? currentUser;
 ChatUser? user;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo().then((user) {
  setState(() {
    currentUser = ChatUser(
      image: user.image,
      about: user.about,
      name: user.name,
      createdAt: user.createdAt,
      lastActive: user.lastActive,
      isOnline: user.isOnline,
      id: user.id,
      email: user.email,
      pushToken: user.pushToken,
    );
    this.user = currentUser;
  });
});

    //APIs.getSelfInfo();
   /*FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
    _firebaseMessaging.getToken().then((token){
      print("token is $token");
  });


    //for updating user active status acoording to lifecycle events
    //resume --> active or online
    //pause --> inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if(APIs.auth.currentUser != null){
        if (message.toString().contains('pause')) APIs.updateActiveStatus(false);
        if (message.toString().contains('resume')) APIs.updateActiveStatus(true);
      }
      

      return Future.value(message);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      //to hide keyboard when a tap is detected on the screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
              onTap: () {
             Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WelcomePage(user: user!)),
      );
    },
    child: Icon(CupertinoIcons.home),
  ),
              centerTitle: true,
              title: _isSearching
                  ? TextField(
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name,Email,..',
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.white)),
                      autofocus: true,
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.5,
                          color: Colors.white),
                      //when search text changes then updated search list
                      onChanged: (val) {
                        //search logic
                        _searchList.clear();

                        for (var i in _list) {
                          if (i.name
                                  .toLowerCase()
                                  .contains(val.toLowerCase()) ||
                              i.email
                                  .toLowerCase()
                                  .contains(val.toLowerCase())) {
                            _searchList.add(i);
                          }
                          setState(() {
                            _searchList;
                          });
                        }
                      },
                    )
                  : Text("SafeHavenChat"),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearching = !_isSearching;
                      });
                    },
                    icon: Icon(_isSearching
                        ? CupertinoIcons.clear_circled_solid
                        : Icons.search)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProfileScreen(
                                    user: APIs.me,
                                  )));
                    },
                    icon: Icon(Icons.more_vert))
              ],
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                onPressed: () async {
                  // await APIs.auth.signOut();
                  // await GoogleSignIn().signOut();
                },
                child: Icon(Icons.message_outlined),
              ),
            ),
            body: StreamBuilder(
                stream: APIs.getAllUsers(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    //data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());

                    //if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      _list = data
                              ?.map((e) => ChatUser.fromJson(e.data()))
                              .toList() ??
                          [];

                      if (_list.isNotEmpty) {
                        return ListView.builder(
                            itemCount: _isSearching
                                ? _searchList.length
                                : _list.length,
                            padding: EdgeInsets.only(top: mq.height * .01),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              //return Text('Name: ${list[index]}');
                              return ChatUserCard(
                                user: _isSearching
                                    ? _searchList[index]
                                    : _list[index],
                              );
                            });
                      } else {
                        return Center(
                          child: Text(
                            'No connection Found',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }
                  }
                })),
      ),
    );
  }
}
