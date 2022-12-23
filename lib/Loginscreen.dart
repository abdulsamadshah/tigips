
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tigips/round_btn.dart';

import 'Uploaddata/addpost.dart';



class adminLoginscreen extends StatefulWidget {
  const adminLoginscreen({Key? key}) : super(key: key);

  @override
  State<adminLoginscreen> createState() => _adminLoginscreenState();
}

class _adminLoginscreenState extends State<adminLoginscreen> {
  TextEditingController userid = TextEditingController();
  TextEditingController password = TextEditingController();
  String useridata = "shivamtigip@gmail.com";
  String passworddata = "tigip@78925";

  final formkey = GlobalKey<FormState>();
  bool loading = false;
  void login(String userid, password) {
    // userid == useridata || password == passworddata
    if (userid == useridata || password == passworddata) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Addpostscreen(),
          ));
      Fluttertoast.showToast(
          msg: 'Login Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurple,
          textColor: Colors.white,
          fontSize: 16.0);
    }else {
      Fluttertoast.showToast(
          msg: 'Something wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurple,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this user user app on exit
      // onWillPop: () async {
      //   SystemNavigator.pop();
      //   return true;
      // },
        appBar: AppBar(
          title:Text("Admin Login"),
          backgroundColor: Color(0XFF7a19ab),
        ),
        body: SingleChildScrollView(

          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 230),
              child: Center(
                child: Form(

                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: userid,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter your User id",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your User id";
                            // Fluttertoast.showToast(msg: "Password is empty",toastLength: Toast.LENGTH_SHORT,backgroundColor: Colors.red);
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter your Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your Password";
                            // Fluttertoast.showToast(msg: "Password is empty",toastLength: Toast.LENGTH_SHORT,backgroundColor: Colors.red);
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50),
                      Roundbtn(
                          loading: loading,
                          title: 'Login',
                          ontap: () {
                            if (formkey.currentState!.validate()) {
                              login(userid.text.toString(), password.text.toString());
                            }
                          }),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }


}
