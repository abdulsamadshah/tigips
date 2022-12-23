
import 'dart:io';

import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



import 'magazineModel.dart';
class PdfViewerPage extends StatefulWidget {

  final Data task;
  PdfViewerPage({Key? key, required this.task}) : super(key: key);
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  var localPath,hello;
  late final Data task;
  var weburl;
  late WebViewController _controller;

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();




  }


  @override
  Widget build(BuildContext context) {


    var url=Uri.parse("https://docs.google.com/viewer?url="+widget.task.file.toString());

        return Scaffold(
        body:Center(
        child: WebView(

        initialUrl:url.toString(),
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
      _controller = webViewController;
    },
    ),
    ));


  }
}



