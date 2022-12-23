import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:tigips/constants/fonts.dart';
import 'package:tigips/login.dart';
import 'package:tigips/subscribe.dart';
import 'package:tigips/videodetail.dart';

import 'videomodel.dart';

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

class Video extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Video> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Video> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int _counter = 0;
  var apiurl;
  var apikey;
  var accesstoken;
  var weburl;
  late Future<List<Data>> hello;
  List _items = [];
  var image, galleryid;
  var userpaidstatus;

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
    hello = getResponse();
  }

  getYoutubeThumbnail(String? videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl!);
    if (uri == null) {
      return null;
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }

  Future<List<Data>> getResponse() async {
    List<Data> list;

    var url =
        Uri.parse("http://freecart.in/abc/adminvideo/mobileapi/getvideo.php");
    http.Response response = await http.post(
      url,
    );

    print("Response" + response.body);
    var data1 = json.decode(response.body);

    var rest = data1["data"] as List<dynamic>;

    list = rest.map<Data>((json) => Data.fromJson(json)).toList();

    return list;
  }

  int _current = 0;

  int index = 1;

  Future<List<Data>> getuserResponse() async {
    List<Data> list;

    var url =
        Uri.parse("http://freecart.in/abc/adminvideo/mobileapi/getuserapi.php");
    http.Response response = await http.post(
      url,
    );

    print("Response" + response.body);
    var data1 = json.decode(response.body);

    var rest = data1["data"] as List<dynamic>;

    list = rest.map<Data>((json) => Data.fromJson(json)).toList();

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //change color
        backgroundColor: Color(0XFFa836e2),
        body: Stack(children: [
          Column(children: [
            Expanded(
                flex: 14,
                child: Container(
                  decoration: BoxDecoration(),
                  child: FutureBuilder<List<Data>?>(
                      future: hello,
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return listViewWidget(
                              (List<Data>.from(snapshot.data!)), context);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                )),
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Subscribe()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0XFF9f21de),
                      // color: Colors.deepPurple,
                    ),
                    child: Text(
                      "Subscribe Now",
                      style: TextStyle(
                        fontFamily: Oxford,
                        color: Color(0xFFFFC300),
                        fontSize: 16,
                      ),
                    ),
                  )),
            ),
          ]),
        ]));
  }

  Widget listViewWidget(List<Data>? article, BuildContext context) {
    return Container(
        child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: article?.length,
            itemBuilder: (context, position) {
              var type = article![position].type;
              return GestureDetector(
                  onTap: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();

                    setState(() {
                      userpaidstatus = sharedPreferences
                          .getString("userpaidstatus")
                          .toString();
                      debugPrint("getuserpaistatus" + userpaidstatus);
                    });

                    if (type == "Free") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(
                                task: article![position],
                              )));
                    } else if (userpaidstatus == 'Paid') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(
                                task: article![position],
                              )));
                    } else if (userpaidstatus == '1') {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Subscribe()));
                    } else {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Subscribe()));
                    }
                  },
                  child: Container(
                      width: 200,
                      height: 180,
                      child: Column(children: [
                        Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.network(
                            getYoutubeThumbnail(
                                'https://www.youtube.com/watch?v=' +
                                    article![position].youtubeid.toString()),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(8),
                        ),
                        SizedBox(
                            child: Text(
                          article[position].name,
                          style: TextStyle(
                            fontFamily:Oxford,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ))
                      ])));
            }));
  }
}
