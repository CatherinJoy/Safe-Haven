import 'package:flutter/material.dart';

import '../Pages/Chatpage.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SafeHavenSupport"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("New Group"),
                  value: "New Group",
                ),
                PopupMenuItem(
                  child: Text("New Broadcast"),
                  value: "New Broadcast",
                ),
                PopupMenuItem(
                  child: Text("Starred Messages"),
                  value: "Starred Messages",
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: "Settings",
                ),
              ];
            },
          ),
          /*IconButton(
              onPressed: () {},
              icon: Icon(Icons.dehaze_rounded),
              //color: Color.fromARGB(255, 182, 130, 77)
              ),*/
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          //labelColor: Colors.purple,
          tabs: [
            Tab(
              text: "Chats",
            ),
            Tab(
              text: "Calls",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          ChatPage(),
          Text("Calls"),
        ],
      ),
    );
  }
}
