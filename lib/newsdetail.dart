import 'dart:convert';

import 'package:flutter/material.dart';
import 'constants/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;

import 'newsmodel.dart';

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
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class NewsDetails extends StatefulWidget {
  // final Data task;
  var img;
  var title, description;

  NewsDetails(this.img, this.title, this.description);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<NewsDetails> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NewsDetails> {
  bool _visible = false;
  bool _passwordVisible = false;
  TextEditingController datecontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();
  int amount = 0;
  var key = "hi";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather

    return Scaffold(
        body: Stack(children: [
      Column(children: [
        Expanded(
            flex: 7,
            child: Container(
                decoration: BoxDecoration(
                  // color: Colors.purpleAccent,
                  color: Color(0XFF7a19ab),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(
                        widget.img,
                        width: MediaQuery.of(context).size.width,
                        height: 320,
                      ),
                      // Container(
                      //     alignment: Alignment.topCenter,
                      //     padding: EdgeInsets.only(left: 10, top: 10),
                      //     child: Row(children: <Widget>[
                      //       Icon(
                      //         Icons.watch_later_outlined,
                      //         size: 15,
                      //         color: Color(0xFF6789CA),
                      //       ),
                      //       Text(
                      //         widget.title,
                      //         style: TextStyle(
                      //             color: Color(0xFF6789CA),
                      //             fontSize: 13,
                      //             fontFamily: 'Source'),
                      //       )
                      //     ])),
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Text(
                              widget.title,
                              style: TextStyle(
                                  // color: Color(0xFF313131),
                                  color: Colors.white,
                                  fontFamily: Oxford,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ))
                          ])),
                      Container(
                          padding: EdgeInsets.only(left: 10, top: 5, right: 2),
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Text(
                              widget.description,
                              style: TextStyle(
                                // color: Color(0xFF777777),
                                color: Colors.white70,
                                fontSize: 14,
                                fontFamily: Oxford,
                              ),
                            )),
                          ])),
                    ],
                  ),
                )))
      ]),
      Visibility(
        visible: _visible,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 10.0),
          child: CircularProgressIndicator(),
        ),
      ),
    ]));
  }
}
