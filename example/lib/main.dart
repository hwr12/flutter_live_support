// Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_live_support/flutter_live_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_support_chat example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("flutter_live_support_example"),
        ),
        body: FlutterSupportChat(
          supporterID: [
            'cedtegapps.de@gmail.com',
          ],
          currentID: "planet12",
          firestoreInstance: FirebaseFirestore.instance,
          onNewCaseText: 'New Support Case',
          createCaseButtonText: "Create Support Case",
          writeMessageText: "Write a Message",
          senderColor: Colors.blue,
          recieverColor: Colors.grey,
        ));
  }
}
