import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

import 'Loginscreen.dart';
import 'Uploaddata/addpost.dart';
import 'constants/fonts.dart';
import 'login.dart';
import 'magazineModel.dart';

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

class Settings extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Settings> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Settings> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int _counter = 0;
  var apiurl;
  var apikey;
  var accesstoken;
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

  @override
  void initState() {
    super.initState();
  }

  int _current = 0;
  final Uri _faqurl =
      Uri.parse('https://theinternationalglamourproject.com/guidelines-faqs/');
  final Uri OurCourcess =
      Uri.parse('https://theinternationalglamourproject.com/who-we-are/');
  final Uri _launchwebsiteurl =
      Uri.parse('https://theinternationalglamourproject.com/');

  int index = 1;

  Future<void> _launchUrl() async {
    if (!await launchUrl(_faqurl)) {
      throw 'Could not launch $_faqurl';
    }
  }

  Future<void> _launchWebsite() async {
    if (!await launchUrl(_launchwebsiteurl)) {
      throw 'Could not launch $_launchwebsiteurl';
    }
  }

  Future<void> launchourcourses() async {
    if (!await launchUrl(OurCourcess)) {
      throw "Courld not launch $OurCourcess";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF7a19ab),
          automaticallyImplyLeading: false,
          title: Text("Setting"),
          // centerTitle: true,
          actions: [
            Visibility(
              visible: true,
              child: InkWell(
                onLongPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => adminLoginscreen(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,top: 7),
                  child: Text(
                    "....",
                    style: TextStyle(color: Color(0XFF7a19ab)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, top: 18),
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
              ),
              child: Text(
                "Save Content to sync across Devices",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.grey, fontFamily: Oxford, fontSize: 12),
              ),
            ),
            Divider(
              height: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Login(title: '')));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20, top: 18),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text(
                  "Create Account",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: Oxford, color: Colors.black, fontSize: 12),
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, top: 18),
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
              ),
              child: Text(
                "Subscriptions",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: Oxford, color: Colors.grey, fontSize: 12),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, top: 18),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                "Activate Subscription",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: Oxford, color: Colors.black, fontSize: 12),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, top: 18),
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
              ),
              child: Text(
                "Help",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: Oxford, color: Colors.grey, fontSize: 12),
              ),
            ),
            Divider(
              height: 1,
            ),
            GestureDetector(
              onTap: () {
                _launchUrl();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20, top: 18),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text(
                  "FAQ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: Oxford, color: Colors.black, fontSize: 12),
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, top: 18),
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
              ),
              child: Text(
                "Website",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.grey, fontFamily: Oxford, fontSize: 12),
              ),
            ),
            Divider(
              height: 1,
            ),
            GestureDetector(
              onTap: () {
                _launchWebsite();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20, top: 18),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text(
                  "Visit Our Website",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily:Oxford, color: Colors.black, fontSize: 12),
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            GestureDetector(
              onTap: () {
                launchourcourses();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20, top: 18),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text(
                  "Our Courses",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: Oxford, color: Colors.black, fontSize: 12),
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, top: 18),
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
              ),
              child: Text(
                "Legal",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily:Oxford, color: Colors.grey, fontSize: 12),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, top: 18),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                "Terms and Conditions",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: Oxford, color: Colors.black, fontSize: 12),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, top: 18),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                "Privacy Policy",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: Oxford, color: Colors.black, fontSize: 12),
              ),
            ),
          ]),
        ));
  }
}
