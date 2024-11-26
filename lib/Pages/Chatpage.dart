import 'package:flutter/material.dart';
import 'package:miniproject/Module/ChatModule.dart';

import '../CustomUI/CustomCard.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  List<ChatModel> chats = [
    ChatModel(
      name: "ABCD",
      isGroup: false,
      currentMessage: "Hi Everyone",
      time: "4:00",
      icon: "img/grpicon.png"
    ),
    ChatModel(
      name: "PQRS",
      isGroup: false,
      currentMessage: "Hello",
      time: "5:00",
      icon: "img/picon.png"
    ),
     ChatModel(
      name: "Y Group",
      isGroup: true,
      currentMessage: "Hello Y Group",
      time: "7:00",
      icon: "img/picon.png"
    ),
    ChatModel(
      name: "XYWZ",
      isGroup: false,
      currentMessage: "Hello World",
      time: "6:00",
      icon: "img/picon.png"
    ),
    ChatModel(
      name: "Q Grp",
      isGroup: true,
      currentMessage: "Hello Group",
      time: "10:00",
      icon: "img/picon.png"
    ),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.chat_outlined),
      ),
      body: ListView.builder(
       itemCount: chats.length,
       itemBuilder: (context, index) => CustomCard(chatModel:chats[index]),
      ),
    );
  }
}
