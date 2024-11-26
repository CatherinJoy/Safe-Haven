//import 'dart:html';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

//import 'package:emoji_picker_2/emoji_picker_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:get/get.dart';
import 'package:miniproject/Module/ChatModule.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 221, 233),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          leadingWidth: 70,
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
                CircleAvatar(
                  child: SvgPicture.asset(
                    widget.chatModel.isGroup
                        ? "assets/groups.svg"
                        : "assets/person.svg",
                    color: Colors.pink,
                    height: 37,
                    width: 37,
                  ),
                  radius: 20,
                  backgroundColor: Color.fromARGB(255, 239, 221, 233),
                )
              ],
            ),
          ),
          title: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.chatModel.name,
                      style: TextStyle(
                        fontSize: 18.5,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    "Last seen at 11:00",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.call)),
            PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("View Contact"),
                    value: "View Contact",
                  ),
                  PopupMenuItem(
                    child: Text("Media, links and docs"),
                    value: "Media, links and docs",
                  ),
                  PopupMenuItem(
                    child: Text("Search"),
                    value: "Search",
                  ),
                  PopupMenuItem(
                    child: Text("Mute Notifications"),
                    value: "Mute Notifications",
                  ),
                ];
              },
            ),
          ],
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WillPopScope(
            child: Stack(
              children: [
                ListView(),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width - 55,
                                  child: Card(
                                      margin: EdgeInsets.only(
                                          left: 2, right: 2, bottom: 8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: TextFormField(
                                        controller: _controller,
                                        focusNode: focusNode,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        minLines: 1,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Type a message",
                                          prefixIcon: IconButton(
                                            icon: Icon(Icons.emoji_emotions),
                                            onPressed: () {
                                              focusNode.unfocus();
                                              focusNode.canRequestFocus = false;
                                              setState(() {
                                                show = !show;
                                              });
                                            },
                                          ),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon:
                                                      Icon(Icons.attach_file)),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.camera_alt))
                                            ],
                                          ),
                                          contentPadding: EdgeInsets.all(5),
                                        ),
                                      ))),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 8, right: 2),
                                child: CircleAvatar(
                                    radius: 25,
                                    child: IconButton(
                                      icon: Icon(Icons.mic),
                                      onPressed: () {},
                                    )),
                              ),
                            ],
                          ),
                          show ? emojiSelect() : Container(),
                        ]))
              ],
            ),
            onWillPop: () {
              if (show) {
                setState(() {
                  show = false;
                });
              } else {
                Navigator.pop(context);
              }
              return Future.value(false);
            },
          )),
    );
  }

  Widget emojiSelect() {
    return SizedBox(
      //height: mq.height*0.35,
      child: EmojiPicker(
        onEmojiSelected: (emoji, category) {
        print(emoji);
        setState(() {
          var emoji;
          _controller.text = _controller.text + emoji.emoji;
        });
      }),
    );
  }
}
