import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


class Contact {
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber});
}

class EmergencyContactsPage extends StatelessWidget {
  final List<Contact> emergencyContacts = [
    Contact(name: 'Police help line', phoneNumber: '100'),
    Contact(name: 'Women help line', phoneNumber: '181'),
    Contact(name: 'Pink police patrol', phoneNumber: '1515'),
    Contact(name: 'Fire force', phoneNumber: '8547673878'),
  ];

  void _makePhoneCall(String phoneNumber) async {
    final bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    if (res == true) {
      print('Call initiated successfully to $phoneNumber in the background!');
    } else {
      throw 'Could not make phone call';
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 229, 234),
      body: Column(
        children: [
          Container(
            width: w,
            height: h * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/SignIn_backgrd.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.14,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 239, 221, 233),
                  radius: 55,
                  backgroundImage: AssetImage("img/s_logo.png"),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: emergencyContacts.length,
              itemBuilder: (context, index) {
                final contact = emergencyContacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phoneNumber),
                  trailing: IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () => _makePhoneCall(contact.phoneNumber),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}