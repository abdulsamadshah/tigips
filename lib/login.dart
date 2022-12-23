import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tigips/signup.dart';
import 'package:tigips/subscribe.dart';
import 'package:tigips/videodetail.dart';

import 'dashboard.dart';
import 'login.dart';

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
      home: const Login(title: 'Flutter Demo Home Page'),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Login> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Login> {
  bool _visible = false;
  bool _passwordVisible = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int _counter = 0;

  var apiurl;
  late String apikey;

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  Future sendRequest() async {
    setState(() {
      _visible = true;
    });

    var url =
        Uri.parse("http://freecart.in/abc/adminvideo/mobileapi/login.php");

    Map data = {
      'mobile': nameController.text,
      'password': passwordController.text,
    };

    String body = json.encode(data);

    http.Response response = await http.post(
      url,
      body: data,
    );

    String resbody = response.body;
    Map<String, dynamic> user = jsonDecode(resbody);

    var userid = user['userid'];
    var status = user['success'];
    var paidstatus = user['paidstatus'];
    var subscriptionstatus = user['status'];
    // print("subcriptionstatus" + subscriptionstatus);

    String status11 = status.toString();
    debugPrint("stuatus"+status11);

    if (status11 == 'true') {
      await saveUserid(userid);
      await saveStatus(paidstatus);
      await setuserpaidstatus(subscriptionstatus);
      debugPrint("stuatus"+subscriptionstatus);

      setState(() {
        _visible = false;
      });

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Subscribe()));
      Fluttertoast.showToast(
          msg: "Login Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFF2855AE),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Wrong Credential",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFF2855AE),
          textColor: Colors.white,
          fontSize: 16.0);

      setState(() {
        _visible = false;
      });
    }
    return response;
  }

  static saveUserid(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString("userid", value);
  }

  static setuserpaidstatus(status) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString("userpaidstatus", status);
  }

  static saveStatus(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString("paidstatus", value);
  }

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
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 100),
                  alignment: Alignment.center,
                  width: 110,
                  height: 60,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: 'Copper',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "Sign in  !",
                    style: TextStyle(
                      fontFamily: 'Copper',
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: nameController,
                    //This will obscure text dynamically
                    decoration: InputDecoration(
                      labelText: 'Mobile No',
                      labelStyle: TextStyle(
                        fontFamily: 'Copper',
                      ),
                      // Here is key idea

                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.black12,
                      ),
                      /*    suffixIcon: IconButton(
                 icon: Icon(
                   // Based on passwordVisible state choose the icon
                   Icons.check_circle,
                   color: Color(0xFF24C6DC),
                 ),
                 onPressed: () {
                   // Update the state i.e. toogle the state of passwordVisible variable
                   setState(() {
                     _passwordVisible = !_passwordVisible;
                   });
                 },
               ),*/
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      //This will obscure text dynamically
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontFamily: 'Copper',
                        ),

                        // Here is key idea

                        prefixIcon: Icon(
                          Icons.lock_open,
                          color: Colors.black12,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.deepPurple,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (nameController.text == '') {
                        Fluttertoast.showToast(
                            msg: "Please Enter Username",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.deepPurple,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (passwordController.text == '') {
                        Fluttertoast.showToast(
                            msg: "Please Enter Password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.deepPurple,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        sendRequest();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            const Color(0XFF9f21de),
                            const Color(0XFF9f21de)
                          ]),
                          borderRadius: BorderRadius.circular(4)),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Press Here to Login',
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Copper',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();

                      setState(() {
                        var userpaidstatus =
                            sharedPreferences.getString("userpaidstatus") ?? '';
                        debugPrint("getuserpaistatus" + userpaidstatus);
                        if (userpaidstatus == 'Paid') {
                          MaterialPageRoute(builder: (context) => Dashboard());
                        } else if (userpaidstatus == '1') {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Subscribe()));
                        } else if (userpaidstatus == '') {
                          MaterialPageRoute(builder: (context) => Subscribe());
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Dashboard()));
                        }
                      });

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUp(title: '')));
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            const Color(0XFF9f21de),
                            const Color(0XFF9f21de)
                          ]),
                          borderRadius: BorderRadius.circular(4)),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Create Account',
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Copper',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Image.asset('assets/images/mylogo.png'),
                    ),
                  ),
                )
              ],
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
            ),
            Visibility(
              visible: _visible,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 10.0),
                child: CircularProgressIndicator(),
              ),
            ),
          ],

          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
