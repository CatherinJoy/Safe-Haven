import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/chatapp/screens/viewProfile_screen.dart';
import 'package:miniproject/main.dart';

import '../../models/chat_user.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key, required this.user});

  final ChatUser user;
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Color.fromARGB(255, 246, 229, 234).withOpacity(.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: mq.width * .6,
        height: mq.height * .35,
        child: Stack(
          children: [
            //user profile picture
            Positioned(
              top: mq.height * .07,
              left: mq.width * .1,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * .25),
                  child: CachedNetworkImage(
                      width: mq.width * .5,
                      fit: BoxFit.fill,
                      imageUrl: user.image,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const CircleAvatar(
                            child: Icon(CupertinoIcons.person),
                          ))),
            ),
            //user name
            Positioned(
                left: mq.width * .04,
                top: mq.height * .02,
                width: mq.width * .55,
                child: Text(
                  user.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                )),

            //info button
            Positioned(
              right: 8,
              top: 4,
              child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ViewProfileScreen(user: user)));
                  },
                  padding: EdgeInsets.all(0),
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.pink,
                    size: 30,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
