import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:miniproject/chatapp/models/chat_user.dart';

import '../models/message.dart';

class API {
  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud firestone database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //for accessing cloud firestone storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  //for storing self information
  static late ChatUser me;
  //static late ChatUser _me;
  //static ChatUser? me;
  //static ChatUser? get me => _me;

  //to return current user
  static User get user => auth.currentUser!;

  //for accessing firebase messaging (Push Notification)
  static FirebaseMessaging fmessaging = FirebaseMessaging.instance;

  //for getting firebase messaging token
  /*static Future<void> getFirebaseMessagingToken() async {
    await fmessaging.requestPermission();

    String? token = await fmessaging.getToken();
    if (token != null) {
      me.pushToken = token;
      log('Push token: $token');
    } else {
      log('Failed to retrieve push token');
    }
  }*/
  // static Future<void> getFirebaseMessagingToken() async {
  //   await fmessaging.requestPermission();

  //   await fmessaging.getToken().then((t) {
  //   if (t != null) {
  //     me.pushToken = t;
  //     log('Push token: $t');
  //   } else {
  //     log('Failed to retrieve push token');
  //   }
  // });
  // }

  //to check if user exists or not
  static Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  //for getting current user info
  /*static Future<ChatUser> getSelfInfo() async {
  final userSnapshot = await firestore
      .collection('users')
      .doc(auth.currentUser!.uid)
      .get();

  if (userSnapshot.exists) {
    final userData = userSnapshot.data()!;
    ChatUser user = ChatUser.fromJson(userData);
    await getFirebaseMessagingToken();

    //for setting user status to active
    await APIs.updateActiveStatus(true);

    if (user.name.isEmpty) {
      user.name = auth.currentUser!.displayName ?? '';
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({'name': user.name});
    }
    if (user.about.isEmpty) {
      user.about = 'Hey there!';
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({'about': user.about});
    }

    return user;
  } else {
    return createUser(); // Assuming this method returns a ChatUser object
  }
}*/

  static Future<ChatUser> getSelfInfo() async {
    final userSnapshot =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data();
      if (userData != null) {
        final me = ChatUser.fromJson(userData);
        //await getFirebaseMessagingToken();

        // for setting user status to active
        await API.updateActiveStatus(true);

        if (me.name.isEmpty) {
          me.name = auth.currentUser!.displayName ?? '';
          await firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .update({'name': me.name});
        }
        if (me.about.isEmpty) {
          me.about = 'Hey there!';
          await firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .update({'about': me.about});
        }

        return me; // Return the user object
      }
    } else {
      await createUser().then((value) => getSelfInfo());
    }

    throw Exception(
        'Failed to fetch self info'); // Throw an exception if self info is not found
  }

  /* static Future<void> getSelfInfo() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        await getFirebaseMessagingToken();
        
    //for setting user status to active
    APIs.updateActiveStatus(true);
        log('My Data: ${user.data()}');
        if (me.name.isEmpty) {
          me.name = auth.currentUser!.displayName ?? '';
          await firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .update({'name': me.name});
        }
        if (me.about.isEmpty) {
          me.about = 'Hey there!';
          await firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .update({'about': me.about});
        }
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }*/

  // await firestore
  //     .collection('users')
  //     .doc(auth.currentUser!.uid)
  //     .get()
  //     .then((user) async {
  //   if (user.exists) {
  //     me = ChatUser.fromJson(user.data()!);
  //     log('My Data: ${user.data()}');
  //   } else {
  //     await createUser().then((value) => getSelfInfo());
  //   }
  // });

  // for creating a new user
  static Future<ChatUser> createUser() async {
    final user = API.auth.currentUser;
    if (user != null) {
      final time = DateTime.now().millisecondsSinceEpoch.toString();

      final chatUser = ChatUser(
        image: user.photoURL ?? '',
        about: 'Hey there!',
        name: user.displayName ?? '',
        createdAt: time,
        lastActive: time,
        isOnline: false,
        id: user.uid,
        email: user.email ?? '',
        pushToken: '',
      );

      final userRef = firestore.collection('users').doc(user.uid);
      await userRef.set(chatUser.toJson());
      return chatUser; // Return the created ChatUser object
    }
    throw Exception(
        'Failed to create user.'); // Throw an exception if user is null
  }

  /*static Future<void> createUser() async {
    final user = APIs.auth.currentUser;
    if (user != null) {
      final time = DateTime.now().millisecondsSinceEpoch.toString();

      final chatUser = ChatUser(
        image: user.photoURL ?? '',
        about: 'Hey there!',
        name: user.displayName ?? '',
        createdAt: time,
        lastActive: time,
        isOnline: false,
        id: user.uid,
        email: user.email ?? '',
        pushToken: '',
      );

      final userRef = firestore.collection('users').doc(user.uid);
      await userRef.set(chatUser.toJson());
    }
  }*/

  //for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  static Future<void> updateUserInfo() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'name': me.name, 'about': me.about});
  }

  //for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUser chatUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  //update profile picture of user
  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  //update profile picture of user
  static Future<void> updateProfilePicture(File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    log('Extension: $ext');

    //storage file ref with path
    final ref = storage.ref().child('Profile Picture/${user.uid}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000}KB');
    });

    //updating image in firestore database
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'image': me.image});
  }

  ///..............Chat Screen Related APIs.................

  //useful for getting conversation id
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  //for getting all msgs of a specific conversation from firebase database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  //for sending message
  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    //message sending time(also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        msg: msg,
        toId: chatUser.id,
        read: '',
        type: type,
        fromId: auth.currentUser!.uid,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  //update read status of message
  static Future<void> updateMessageReadStatus(Message message) async {
    final conversationID = getConversationID(message.fromId);
    final messageRef = firestore
        .collection('chats/$conversationID/messages/')
        .doc(message.sent);

    // check if the message exists and has not been read
    final messageDoc = await messageRef.get();
    if (messageDoc.exists && messageDoc.data()!['read'].isEmpty) {
      await messageRef
          .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
    }
    // firestore
    //     .collection('chats/${getConversationID(message.fromId)}/messages/')
    //     .doc(message.sent)
    //     .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //get only last msg of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //send chat image
  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storage.ref().child(
        'images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000}KB');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }
}
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  /*static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
        image: user.photoURL.toString(),
        about: "Hey there!",
        name: user.displayName.toString(),
        createdAt: time,
        lastActive: time,
        isOnline: false,
        id: user.uid,
        email: user.email.toString(),
        pushToken: ''
        );

    return await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
       
  }*/

