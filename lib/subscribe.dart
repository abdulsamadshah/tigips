import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tigips/dashboard.dart';
import 'package:tigips/login.dart';
import 'package:tigips/newsdetail.dart';
import 'package:tigips/videodetail.dart';
import 'package:tigips/subscriptionmodel.dart';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

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

class Subscribe extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Subscribe> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Subscribe> {
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
  Razorpay? _razorpay;
  var amount;
  var userid;
  bool _visible = false;
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

  Future<dynamic> createOrder() async {
    String str = amount;
    var arr = str.split('.');
    amount = int.parse(amount);
    var mapHeader = <String, String>{};
    mapHeader['Authorization'] =
        "Basic cnpwX3Rlc3RfU2RHQmFoV3RsS1dNd2I6Mlh2WElOSDlMcG9xTHdyU3F5cDFzam5y";
    mapHeader['Accept'] = "application/json";
    mapHeader['Content-Type'] = "application/x-www-form-urlencoded";
    var map = <String, String>{};
    setState(() {
      map['amount'] = "${(amount * 100)}";
    });
    map['currency'] = "INR";
    map['receipt'] = "receipt1";
    print("map $map");
    var response = await http.post(Uri.https("api.razorpay.com", "/v1/orders"),
        headers: mapHeader, body: map);
    print("...." + response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> user = jsonDecode(response.body);
      var id = user['id'];
      var options = {
        "key": "rzp_live_DGvmYJT8b8hHB0",
        // "amount": int.parse(amount) * 100, // Convert Paisa to Rupees
        "amount": int.parse(amount) * 100, // Convert Paisa to Rupees
        "name": "TIGP",
        "description": "",
        "timeout": "180",
        "theme.color": "#2855AE",
        "currency": "INR",
        "prefill": {"contact": "", "email": ""},
      };
      openCheckout(options);
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }

  void openCheckout(var data) async {
    try {
      _razorpay?.open(data);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future getuserid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userid = sharedPreferences.getString("userid").toString();
      debugPrint("getuserids" + userid);
    });
  }

  @override
  void initState() {
    super.initState();
    getuserid();
    hello = getResponse();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: " Payment Successfully");

    sendRequest();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "Payment Successfully");
  }

  Future sendRequest() async {
    setState(() {
      _visible = true;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userid = sharedPreferences.getString("userid").toString();
      debugPrint("getuseridssetstate" + userid);
    });

    var url = Uri.parse(
        "http://freecart.in/abc/adminvideo/mobileapi/updatepaidstatus.php");

    Map data = {
      'userid': userid,
    };
    debugPrint("Mapuserids" + userid);
    String body = json.encode(data);

    http.Response response = await http.post(
      url,
      body: data,
    );

    String resbody = response.body;
    Map<String, dynamic> user = jsonDecode(resbody);

    var status = user['success'];
    debugPrint("subcribestatus" + status);

    String status11 = status.toString();

    if (status11 == 'true') {
      setState(() {
        _visible = false;
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login(title: '')));
      Fluttertoast.showToast(
          msg: "Send Request Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFF5E35B1),
          textColor: Colors.white,
          fontSize: 16.0);
    }

    return response;
  }

  int _current = 0;

  int index = 1;

  Future<List<Data>> getResponse() async {
    List<Data> list;

    var url = Uri.parse(
        "http://freecart.in/abc/adminvideo/mobileapi/getsubcription.php");
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
        appBar: AppBar(
            title: const Text(
              'Subscription',
              style: TextStyle(
                fontFamily: 'Copper',
              ),
            ),
            backgroundColor: Colors.deepPurple),
        body: FutureBuilder<List<Data>>(
            future: hello,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                amount = snapshot.data![0].amount;

                return Column(children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 20, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        "assets/images/mylogo.png",
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 20, top: 10),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                      "Subscription Options",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Copper',
                          color: Color(0XFF7B19AA),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.deepPurple,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 20, top: 10),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Text(
                            "Subscription Amount",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Copper',
                              color: Color(0XFF7B19AA),
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 20, top: 10),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Text(
                            "Rs." + snapshot.data![0].amount,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Copper',
                              color: Color(0XFF7B19AA),
                              fontSize: 10,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 1,
                    color: Colors.deepPurple,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 10),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                      "Subscription will unlock contents ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Copper',
                          color: Color(0XFF7B19AA),
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();

                      setState(() {
                        userid = sharedPreferences.getString("userid") ?? '';
                        debugPrint("getuseridssetstateidclick" + userid);
                      });

                      SharedPreferences sharedPreferencess = await SharedPreferences.getInstance();

                      setState(() {
                         userpaidstatus = sharedPreferencess.getString("userpaidstatus") ?? '';
                        debugPrint("getuserpaistatus" + userpaidstatus);

                      });

                      if(userpaidstatus == 'Paid'){
                        Fluttertoast.showToast(
                            msg: "You are already purchased",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color(0xFF2855AE),
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }else if (userid.isEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login(title: '')));
                      } else if (userid == '') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login(title: '')));
                      } else if (userid != null) {
                        createOrder();
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login(title: '')));
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 10),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Text(
                        "Click here to subscribe ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Copper',
                            color: Color(0XFF7B19AA),
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ]);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
