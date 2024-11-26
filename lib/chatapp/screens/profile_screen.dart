import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniproject/chatapp/models/chat_user.dart';

import '../../hompepage.dart';
import '../../main.dart';
import '../widgets/chatuserCard.dart';
import '../api/apis.dart';
import '../auth/loginscreen.dart';
import '../helper/dialogs.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;
  late TextEditingController _nameController;
  late TextEditingController _aboutController;
  ChatUser? me;

  /*ChatUser me = ChatUser(
    image: '',
    about: '',
    name: '',
    createdAt: '',
    lastActive: '',
    isOnline: false,
    id: '',
    email: '',
    pushToken: '',
  );*/

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
    _nameController = TextEditingController(text: widget.user.name);
    _aboutController = TextEditingController(text: widget.user.about);
    initializeMe();
    //me = widget.user;

    // Assign values to `me` object
    /*me = ChatUser(
      image: widget.user.image,
      about: widget.user.about,
      name: widget.user.name,
      createdAt: widget.user.createdAt,
      lastActive: widget.user.lastActive,
      isOnline: widget.user.isOnline,
      id: widget.user.id,
      email: widget.user.email,
      pushToken: widget.user.pushToken,
    );*/
  }

  Future<void> initializeMe() async {
    me = await APIs.getSelfInfo();
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Profile Screen"),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.red,
              onPressed: () async {
                //for showing progress dialog
                Dialogs.showProgressbar(context);

                await APIs.updateActiveStatus(false);

                //sign out
                await APIs.auth.signOut().then((value) async {
                  await GoogleSignIn().signOut().then((value) {
                    //for hiding progress dialog
                    Navigator.pop(context);

                    //move to homescreen
                    Navigator.pop(context);

                    //to prevent storing old data
                    APIs.auth = FirebaseAuth.instance;

                    //replacing home screen with login screen
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => HomePage(user: widget.user)));
                  });
                });
              },
              icon: const Icon(Icons.logout),
              label: const Text('LogOut'),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .1),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //adding space
                    SizedBox(
                      width: mq.width,
                      height: mq.height * .03,
                    ),
                    Stack(
                      children: [
                        //Profile Pic
                        _image != null
                            ?
                            //local image
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(mq.height * .3),
                                child: Image.file(
                                  File(_image!),
                                  width: mq.height * .15,
                                  height: mq.height * .15,
                                  fit: BoxFit.cover,
                                ))
                            :

                            //image from server
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
                        //edit profile pic
                        Positioned(
                          bottom: 0,
                          right: -17,
                          child: MaterialButton(
                            elevation: 1,
                            onPressed: () {
                              _showBottomSheet();
                            },
                            shape: const CircleBorder(),
                            color: Colors.purpleAccent,
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: mq.width,
                      height: mq.height * .03,
                    ),

                    Text(
                      widget.user.email,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                    ),

                    SizedBox(
                      width: mq.width,
                      height: mq.height * .05,
                    ),

                    TextFormField(
                      controller: _nameController,
                      //initialValue: me?.name,
                      //to prevent empty field in username
                      //onSaved: (val) => me.name = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',

                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.pinkAccent,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Your username',
                        label: const Text('Name'),
                      ),
                    ),
                    SizedBox(
                      width: mq.width,
                      height: mq.height * .02,
                    ),
                    TextFormField(
                      controller: _aboutController,
                      //initialValue: me?.about,
                      //to prevent empty field in about
                      //onSaved: (val) => me.about = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',

                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.info_outline,
                            color: Colors.pinkAccent),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Your Description',
                        label: const Text('About'),
                      ),
                    ),
                    SizedBox(
                      width: mq.width,
                      height: mq.height * .05,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.purple,
                          minimumSize: Size(mq.width * .35, mq.height * .055)),
                      onPressed: () {
                        // if (widget.user != null) {
                        // Your code using `me` goes here
                        widget.user.name = _nameController.text;
                        widget.user.about = _aboutController.text;
                        APIs.updateUserInfo().then((value) {
                          Dialogs.showSnackbar(
                            context,
                            'Profile Updated Successfully!',
                          );
                        });
                        /*} else {
                      Dialogs.showSnackbar(
                        context,
                        'Error: User data not available',
                      );
                      }*/

                        /*if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          widget.user.name = _nameController.text;
                          widget.user.about = _aboutController.text;

                          APIs.updateUserInfo().then((value) {
                            Dialogs.showSnackbar(
                                context, 'Profile Updated Successfully!');
                          });
                        }*/
                        // if (_formKey.currentState!.validate()) {
                        //   _formKey.currentState!.save();
                        //   APIs.updateUserInfo().then((value) {
                        //     Dialogs.showSnackbar(
                        //         context, 'Profile Updated Successfully!');
                        //   });
                        // }
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text(
                        'UPDATE',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: mq.height * .02, bottom: mq.height * .1),
            children: [
              const Text('Pick Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick from gallery
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        fixedSize: Size(mq.width * .3, mq.height * .15),
                      ),
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path} -- MimeType: ${image.mimeType})');
                          setState(() {
                            _image = image.path;
                          });
                          APIs.updateProfilePicture(File(_image!));

                          //for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('img/proimg.png')),

                  //use camera
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 240, 199, 213),
                        shape: const CircleBorder(),
                        fixedSize: Size(mq.width * .3, mq.height * .15),
                      ),
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));
                          //for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('img/cam2.png'))
                ],
              )
            ],
          );
        });
  }
}
