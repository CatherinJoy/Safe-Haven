import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../api/apis.dart';
import '../helper/date_util.dart';
import '../models/message.dart';
import '../../main.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});
  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return APIs.user.uid == widget.message.fromId
        ? _purpleMessage()
        : _pinkMessage();
  }

  //sender or another user msg
  Widget _pinkMessage() {
    //update last read message if sender and reciever are different
    if (widget.message.read.isEmpty) {
      APIs.updateMessageReadStatus(widget.message);
      log('message read updated');
    }
    return Row(
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image?mq.width *.03:mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 244, 205, 218),
                border: Border.all(color: Colors.pinkAccent),

                //making border curved
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
            child: 
            widget.message.type == Type.text? 
            Text(widget.message.msg,
                style: TextStyle(fontSize: 15, color: Colors.black87))
                //if text show text if image show image(instead of url in text form)
                :ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                  imageUrl: widget.message.msg,
                  placeholder: (context, url) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget:  (context, url,error) => Icon(Icons.image,size: 60,),
                      ))
                      ),
          ),
        
        //SizedBox(width: .1,),
        Text(
            MyDateUtil.getFormattedTime(
                context: context, time: widget.message.sent),
            style: TextStyle(fontSize: 13, color: Colors.black54))
      ],
    );
  }

  //our or user msg
  Widget _purpleMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //SizedBox(width: .1,),
        Row(
          children: [
            //double tick purple icon
            if (widget.message.read.isNotEmpty)
              Icon(Icons.done_all_rounded,
                  color: Color.fromARGB(255, 110, 15, 126), size: 20),
            //time sent
            Text(
                MyDateUtil.getFormattedTime(
                    context: context, time: widget.message.sent),
                style: TextStyle(fontSize: 13, color: Colors.black54)),
          ],
        ),

        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image?mq.width *.03:mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 204, 185, 207),
                border: Border.all(color: Colors.purple),

                //making border curved
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )),
            child: 
             widget.message.type == Type.text? 
            Text(widget.message.msg,
                style: TextStyle(fontSize: 15, color: Colors.black87))
                //if text show text if image show image(instead of url in text form)
                :ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                  imageUrl: widget.message.msg,
                  placeholder: (context, url) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget:  (context, url,error) => Icon(Icons.image,size: 60,),
                      ))
          ),
        ),
      ],
    );
    ;
  }
}
