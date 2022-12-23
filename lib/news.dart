import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tigips/signup.dart';
import '../services/local_notification_service.dart';
import 'package:tigips/subscribe.dart';

import 'package:firebase_database/firebase_database.dart';
import 'constants/fonts.dart';
import 'login.dart';
import 'newsdetail.dart';
import 'newsmodel.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

class News extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<News> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<News> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int _counter = 0;

  var userid;
  late Future<List<Data>> hello;
  List _items = [];
  var image, galleryid;

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

  final dbRef = FirebaseDatabase.instance.reference().child("posts");

  int _current = 0;

  int index = 1;

  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0XFFCBC3E3),
        backgroundColor: Color(0XFFa836e2),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FirebaseAnimatedList(
                      query: dbRef.ref.child("news"),
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        // Map<String, dynamic> datas = jsonDecode(jsonEncode(snapshot.value))  as Map<String, dynamic>;
                        Map student = snapshot.value as Map;
                        student['key'] = snapshot.key;

                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 10, right: 10, bottom: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                // color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsDetails(
                                          student['newimage'],
                                          student["newtitle"],
                                          student["newdescription"]),
                                    ));
                              },
                              child: Container(
                                color: Color(0XFFa836e2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: FadeInImage.assetNetwork(
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .25,
                                            placeholder:
                                                "assets/images/placeholderimg.png",
                                            image: student['newimage']),
                                      ),
                                    ),
                                    Container(
                                      //desing containr
                                      // decoration: BoxDecoration(
                                      //   // color: Color(0XFF1A1A1C),
                                      //   // borderRadius: BorderRadius.circular(2.0),
                                      //   borderRadius: BorderRadius.only(
                                      //       topRight: Radius.circular(5.0),
                                      //       bottomRight: Radius.circular(5.0)),
                                      //
                                      //   //use two colors then use this
                                      //   // gradient: LinearGradient(
                                      //   //     colors: [
                                      //   //       Colors.indigo,
                                      //   //       Colors.blueAccent
                                      //   //     ]
                                      //   // ),
                                      // ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 5),
                                        child: Text(
                                          student['newtitle'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: Oxford),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Visibility(
                                          visible: false,
                                          child: Text(
                                            student['newdescription'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Subscribe()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // color: Colors.deepPurple,
                        // color: Color(0XFF7a19ab),
                        color: Color(0XFF9f21de),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Subscribe Now",
                            style: TextStyle(
                              fontFamily: 'Medium',
                              fontSize: 16,
                              color: Color(0xFFFFC300),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ]));
  }
}
