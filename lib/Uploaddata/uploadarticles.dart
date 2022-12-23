import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tigips/round_btn.dart';

import '../Utils.dart';

class uploadarticles extends StatefulWidget {
  const uploadarticles({Key? key}) : super(key: key);

  @override
  State<uploadarticles> createState() => _AddpostscreenState();
}

class _AddpostscreenState extends State<uploadarticles> {
  bool showspinnner = false;
  final postRef = FirebaseDatabase.instance.reference().child("posts");
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? image;
  TextEditingController titlecontraoller = TextEditingController();
  TextEditingController desccontraoller = TextEditingController();
  final picker = ImagePicker();

  Future getImagegallery() async {
    final pickdFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickdFile != null) {
        image = File(pickdFile.path);
      } else {
        print("no image selected");
      }
    });
  }

  Future getImageCamera() async {
    final pickdFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickdFile != null) {
        image = File(pickdFile.path);
      } else {
        print("no image selected");
      }
    });
  }

  void dailog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getImageCamera();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Camera"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImagegallery();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.browse_gallery),
                      title: Text("Gallery"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinnner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF301934),
          title: Text("Upload Articles"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    dailog(context);
                  },
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.height * 1,
                      child: image != null
                          ? ClipRect(
                        child: Image.file(
                          image!.absolute,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                          : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titlecontraoller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Title",
                          hintText: "Enter post titles",
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          labelStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: desccontraoller,
                        minLines: 1,
                        maxLines: 8,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Description",
                          hintText: "Enter post Description",
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          labelStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Roundbtn(
                          title: "Upload Article",
                          ontap: () async {
                            setState(() {
                              showspinnner = true;
                            });

                            try {
                              int date = DateTime.now().microsecondsSinceEpoch;

                              firebase_storage.Reference ref = firebase_storage
                                  .FirebaseStorage.instance
                                  .ref("/tigip$date");

                              UploadTask uploadtask =
                              ref.putFile(image!.absolute);
                              await Future.value(uploadtask);
                              var newUrl = await ref.getDownloadURL();

                              postRef
                                  .child("articles")
                                  .child(date.toString())
                                  .set({
                                "Pid": date.toString(),
                                "articleimage": newUrl.toString(),
                                "articletitle": titlecontraoller.text.toString(),
                                "articledescription": desccontraoller.text.toString(),
                              }).then((value) {
                                Utils().statusmessage(
                                    "Articles uploaded successfully");
                                setState(() {
                                  showspinnner = false;
                                });
                              }).onError((error, stackTrace) {
                                Utils().statusmessage(error.toString());
                                setState(() {
                                  showspinnner = false;
                                });
                              });
                            } catch (e) {
                              setState(() {
                                showspinnner = false;
                              });
                              Utils().statusmessage(e.toString());
                            }
                          }),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
