import 'dart:async';

import 'package:flutter/material.dart';

import 'dashboard.dart';




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
      home: const Spalsh(title: 'Flutter Demo Home Page'),
    );
  }
}

class Spalsh extends StatefulWidget {
  const Spalsh({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Spalsh> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Spalsh> {
  int _counter = 0;
 var name;








  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }
  void initState() {
    super.initState();




      Timer(Duration(seconds: 3),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>
                  Dashboard()
              )
          )
      );

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


      body:

          Stack(

            children:[


        Container(

    decoration: BoxDecoration(

    ),
   
        child:Column(
          
          children: [
    Expanded(

      child:
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,

              child: Image.asset("assets/images/mylogo.png"),
              
            )),

          ],
          
          
        )

        
)
    ]));
  }
}
