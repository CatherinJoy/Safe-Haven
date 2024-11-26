import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniproject/chatapp/helper/date_util.dart';
import 'package:miniproject/chatapp/models/chat_user.dart';
import 'package:miniproject/chatapp/models/message.dart';
import 'package:miniproject/chatapp/screens/viewProfile_screen.dart';
import 'package:miniproject/chatapp/widgets/msg_card.dart';

import '../../main.dart';
import '../api/apis.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //for stoaring all msgs
  List<Message> _list = [];

  //for sending message text changes
  final _textController = TextEditingController();

  //_showEmoji-->for storing value of showing or hiding emoji
  //_isUploading-->for checking if img is uploading or not
  bool _showEmoji = false, _isUploading = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          //if back button clicked close emojis and show current screen
          onWillPop: () {
            if (_showEmoji) {
              setState(() {
                _showEmoji = !_showEmoji;
              });
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: _appBar(),
            ),
            backgroundColor: Color.fromARGB(255, 246, 229, 234),
            //body
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: APIs.getAllMessages(widget.user),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          //data is loading
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const SizedBox();

                          //if some or all data is loaded then show it
                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;
                            if (data != null && data.isNotEmpty) {
                              // Process and display the data

                              // final jsonData =
                              //     data.map((doc) => doc.data()).toList();
                              // final jsonString = jsonEncode(jsonData);
                              // debugPrint('Data: $jsonString');
                            }
                            //log('Data: ${jsonEncode(data![0].data())}');
                            _list = data
                                    ?.map((e) => Message.fromJson(e.data()))
                                    .toList() ??
                                [];

                            if (_list.isNotEmpty) {
                              return ListView.builder(
                                  reverse: true,
                                  itemCount: _list.length,
                                  padding:
                                      EdgeInsets.only(top: mq.height * .01),
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return MessageCard(
                                      message: _list[index],
                                    );
                                    //return
                                  });
                            } else {
                              return Center(
                                child: Text(
                                  'Say Hi!🙋',
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }
                        }
                      }),
                ),

                //progress indicator for showing uploading
                if (_isUploading)
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: CircularProgressIndicator(strokeWidth: 2))),

                _chatInput(),

                //show emoji on keyboard emoji button click and vice versa
                if (_showEmoji)
                  SizedBox(
                    height: mq.height * .35,
                    child: EmojiPicker(
                      textEditingController: _textController,
                      config: Config(
                        bgColor: Color.fromARGB(255, 246, 229, 234),
                        columns: 8,
                        initCategory: Category.SMILEYS,
                        //emojiSizeMax: 32 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ViewProfileScreen(user: widget.user)));
        },
        child: StreamBuilder(
            stream: APIs.getUserInfo(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              return Row(
                children: [
                  //back button
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .3),
                      child: CachedNetworkImage(
                          width: mq.height * .055,
                          height: mq.height * .055,
                          imageUrl: list.isNotEmpty
                              ? list[0].image
                              : widget.user.image,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                child: Icon(CupertinoIcons.person),
                              ))),
                  SizedBox(
                    width: 10,
                  ),
                  //user name and last seen time
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //user name
                      Text(
                        list.isNotEmpty ? list[0].name : widget.user.name,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),

                      Text(
                        list.isNotEmpty
                            ? list[0].isOnline
                                ? 'Online'
                                : MyDateUtil.getLastActiveTime(
                                    context: context,
                                    lastActive: list[0].lastActive)
                            : MyDateUtil.getLastActiveTime(
                                context: context,
                                lastActive: widget.user.lastActive),
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                    ],
                  )
                ],
              );
            }));
  }

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .03),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _showEmoji = !_showEmoji;
                        });
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.deepPurple, size: 25)),

                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Type Something...',
                      hintStyle: TextStyle(
                        color: Colors.deepPurple,
                      ),
                      border: InputBorder.none,
                    ),
                  )),

                  //gallery
                  IconButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        // Pick multiple images
                        final List<XFile> images =
                            await _picker.pickMultiImage(imageQuality: 70);
                        //uploading & sending images one by one
                        for (var i in images) {
                          log('Image Path:${i.path}');
                          setState(() => _isUploading = true);
                          await APIs.sendChatImage(widget.user, File(i.path));
                          setState(() => _isUploading = false);
                        }
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Colors.deepPurple,
                        size: 26,
                      )),

                  //camera
                  IconButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.camera, imageQuality: 70);
                        if (image != null) {
                          log('Image Path: ${image.path}');

                          await APIs.sendChatImage(
                              widget.user, File(image.path));
                        }
                      },
                      icon: const Icon(Icons.camera_alt_rounded,
                          color: Colors.deepPurple, size: 26)),
                ],
              ),
            ),
          ),

          //send message button
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                APIs.sendMessage(widget.user, _textController.text, Type.text);
                _textController.text = '';
              }
            },
            minWidth: 0,
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Color.fromARGB(255, 24, 139, 30),
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 28,
            ),
          ),
          //adding some space
          SizedBox(
            width: mq.width * .02,
          ),
        ],
      ),
    );
  }
}
