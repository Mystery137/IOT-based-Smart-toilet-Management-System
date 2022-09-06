import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soe/models/currentUser.dart';
import 'package:soe/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:soe/services/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  _getToken() {
    _firebaseMessaging.getToken().then(
      (value) {
        print("Device token : $value");
      },
    );
  }

  _configureFirebaseListner() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print(message.data);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print(message.data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
    _configureFirebaseListner();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<CurrentUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
