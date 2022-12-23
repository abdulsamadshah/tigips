import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tigips/settings.dart';
import 'package:tigips/video.dart';

import 'dart:ui' as ui;

import 'Articles.dart';
import 'magazine.dart';
import 'news.dart';

// function to trigger the app build
void main() {
  runApp(const Dashboard());
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          //dark purple
          backgroundColor: Color(0XFF7a19ab),
          title: new Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 55),
            child: Text(
              "TIGP",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roster',
                fontSize: 32,
                color: Color(0xFFFFC300),
                // fontStyle: FontStyle.italic,
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return ui.Gradient.linear(
                      Offset(4.0, 24.0),
                      Offset(24.0, 4.0),
                      [
                        Color(0xFFF57F17),
                        Color(0xFFFFEE58),
                      ],
                    );
                  },
                  child: Icon(Icons.settings)),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xFF999966),
            labelStyle: TextStyle(fontSize: 11, fontFamily: 'Copper'),
            tabs: [
              Tab(
                icon: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return ui.Gradient.linear(
                      Offset(4.0, 24.0),
                      Offset(24.0, 4.0),
                      [
                        Color(0xFFF57F17),
                        Color(0xFFFFEE58),
                      ],
                    );
                  },
                  child: Icon(Icons.article_outlined, size: 30),
                ),
                text: "NEWS",
              ),
              Tab(
                icon: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return ui.Gradient.linear(
                        Offset(4.0, 24.0),
                        Offset(24.0, 4.0),
                        [
                          Color(0xFFF57F17),
                          Color(0xFFFFEE58),
                        ],
                      );
                    },
                    child: Icon(Icons.video_call_outlined, size: 30)),
                text: "Videos",
              ),
              Tab(
                icon: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return ui.Gradient.linear(
                        Offset(4.0, 24.0),
                        Offset(24.0, 4.0),
                        [
                          Color(0xFFF57F17),
                          Color(0xFFFFEE58),
                        ],
                      );
                    },
                    child: Icon(Icons.book_outlined, size: 30)),
                text: "Releases",
              ),
              Tab(
                icon: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return ui.Gradient.linear(
                        Offset(4.0, 24.0),
                        Offset(24.0, 4.0),
                        [
                          Color(0xFFF57F17),
                          Color(0xFFFFEE58),
                        ],
                      );
                    },
                    child: Icon(Icons.article, size: 30)),
                text: "Articles",
              ),
            ],
          ),
        ), // AppBar
        body: WillPopScope(
          onWillPop: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            return Future.value(true);
          },

          child: TabBarView(
            children: [
              News(),
              Video(),
              Magazine(),
              Articles(),
            ],
          ), // TabBarView
        ), // Scaffold
      ), // DefaultTabController
    )); // MaterialApp
  }
}
