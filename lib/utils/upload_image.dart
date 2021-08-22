import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/utils/firebase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class UploadedPickPage extends StatefulWidget {
  @override
  UploadedPickPageState createState() => UploadedPickPageState();
}

class UploadedPickPageState extends State<UploadedPickPage> {
  late SharedPreferences loginData;
  var imageUrl;
  // late SharedPreferences userImage;
  var userEmail;
  final double size = 100;
  late Future<File> _imageFile;

  String? _image;

  var _imageUrl;

  @override
  void initState() {
    super.initState();
    getLoginData();
    loadImage();
  }

  void getLoginData() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      userEmail = loginData.getString('userEmail')!;
      print('userEmail: $userEmail');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white),
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.logout_outlined,
                ),
                onPressed: () {
                  loginData.setBool('login', true);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                })
          ],
        ),
        body: profilePickUi());
  }

  final _storage = FirebaseStorage.instance;
  final _picker = ImagePicker();

  pickImage() async {
    File _imageFile;
    //select Image
    final pickedFile = (await _picker.getImage(source: ImageSource.gallery))!;

    _imageFile = File(pickedFile.path);
    var fileName = basename(_imageFile.path);

    if (_imageFile != null) {
      //Upload to Firebase
      var snapshot = await _storage.ref().child(fileName).putFile(_imageFile);

      var downloadedUrl = await snapshot.ref.getDownloadURL();
      SharedPreferences saveimage = await SharedPreferences.getInstance();
      saveimage.setString("image", downloadedUrl);
      setState(() {
        imageUrl = downloadedUrl;
      });
      print('imageurl:' '$imageUrl');
      print("filename: $fileName");
    } else {
      print('No path Recieved');
    }
  }

  getDocumentandUpdateDoc() {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((docs) async {
        print(docs["emailId"]);
        print(docs.id);
        if (docs['emailId'] == userEmail) {
          updateUrl(docId: docs.reference.id, image: imageUrl);
          loadImage();
          print(docs.id);
          print(userEmail);
        } else {
          print("Notes not upated");
        }
      });
    });
  }

  void loadImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    print("getImage");
    print(saveimage.getString("image"));
    setState(() {
      _image = saveimage.getString("image");
    });
  }

  Widget profilePickUi() {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          child: Column(children: [
            SizedBox(
              height: 60,
            ),
            Text(
              "Profile Picture",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              // padding: EdgeInsets.only(left: 10),
              child: Text(
                "A picture helps people recognize you and lets you",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ),
            Text(
              "know when you're signed in to your account",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 60,
            ),
            //_imagePath != null
            _image != null
                ? CircleAvatar(
                    radius: size, backgroundImage: NetworkImage(_image!))
                : CircleAvatar(
                    radius: size,
                    child: Icon(Icons.person),
                  ),
            // width: size * 2, height: size * 2, fit: BoxFit.cover),
            // radius: size,

            SizedBox(
              height: 30,
            ),
            FlatButton(
                onPressed: () {
                  pickImage();
                },
                child: Container(
                  width: 300,
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70,
                      ),
                      Icon(Icons.add_a_photo_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Add profile picture")
                    ],
                  ),
                  color: Colors.orange,
                )),
            SizedBox(
              height: 20,
            ),
            FlatButton(
                onPressed: () {
                  getDocumentandUpdateDoc();
                },
                //updateUrlInFirebase();
                child: Container(
                  width: 300,
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                      ),
                      Text("Save profile picture")
                    ],
                  ),
                  color: Colors.orange,
                )),
          ]),
        ),
      ),
    );
  }
}
