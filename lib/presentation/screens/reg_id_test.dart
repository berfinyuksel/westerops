import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class RegIDTest extends StatefulWidget {
  RegIDTest({Key? key}) : super(key: key);

  @override
  _RegIDTestState createState() => _RegIDTestState();
}

class _RegIDTestState extends State<RegIDTest> {
  late FirebaseMessaging messaging;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print(value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}