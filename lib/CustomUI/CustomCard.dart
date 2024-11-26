import 'package:flutter/material.dart';
import 'package:miniproject/Module/ChatModule.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miniproject/Screen/Individualpage.dart';

class CustomCard extends StatelessWidget {
  //const CustomCard{(Key key,this.chatModel)} : super{key: key};
  const CustomCard({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IndividualPage(chatModel: chatModel,)));
        },
        child: Column(children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: SvgPicture.asset(
                chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg",
                color: Colors.pink,
                height: 37,
                width: 37,
              ),
              backgroundColor: Color.fromARGB(255, 239, 221, 233),
            ),
            title: Text(
              chatModel.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 4,
                ),
                Text(
                  chatModel.currentMessage,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Text(chatModel.time),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              height: 0.3,
              thickness: 1.8,
            ),
          )
        ]));
  }
}
