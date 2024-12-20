//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/E_Contact.dart';
import 'package:miniproject/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miniproject/chatapp/screens/chathome.dart';
import 'package:miniproject/google_map_page.dart';
import 'package:miniproject/provider/location_provider.dart';
import 'package:provider/provider.dart';
//import 'chatapp/screens/splash_screen.dart';
import 'chatapp/models/chat_user.dart';
import 'chatapp/screens/splash_screen.dart';
import 'firebase_options.dart';
//import 'package:miniproject/gsignin.dart';
//import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'chatapp/auth/loginscreen.dart';
import 'hompepage.dart';
import 'register_page.dart';
import 'Screen/chat_home.dart';
import 'sign_up.dart';
import 'welcome_page.dart';
import 'package:get/get.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);*/
   
  await Firebase.initializeApp();
  // Create a ChatUser object with the required properties
  ChatUser user = ChatUser(
    image: 'image-value',
    about: 'about-value',
    name: 'name-value',
    createdAt: 'created-at-value',
    lastActive: 'last-active-value',
    isOnline: true,
    id: 'id-value',
    email: 'email-value',
    pushToken: 'push-token-value',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationProvider>(
          create: (_) => LocationProvider(),
        ),
        // Add more providers if needed
      ],
      child: MyApp(user: user),
    ),
  );
 // runApp(MyApp(user: user));
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ChatUser user;

  MyApp({required this.user});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "OpenSans",
        primarySwatch: Colors.pink,
      ),
      //home: GoogleMapPage(),
      home: HomePage(user: user),
    );
  } 
}
_initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}





/*void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFirebase();
    runApp(MyApp());
  });
  //await Firebase.initializeApp().then((value) => Get.put(AuthController()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "OpenSans",
          primarySwatch: Colors.pink,
        ),
        home: ChatH());
  }
}*/
/*=> ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child:*/















/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/