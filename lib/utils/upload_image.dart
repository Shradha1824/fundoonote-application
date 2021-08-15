import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UploadedPickPage extends StatefulWidget {
  @override
  UploadedPickPageState createState() => UploadedPickPageState();
}

class UploadedPickPageState extends State<UploadedPickPage> {
  var imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white)),
      body: Center(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              imageUrl != null
                  ? CircleAvatar(
                      child: ClipOval(
                        child: Image.network(imageUrl),
                      ),
                      radius: 100,
                    )
                  : CircleAvatar(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 150,
                      ),
                      backgroundColor: Colors.orange,
                      radius: 100,
                    ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                  onPressed: () {
                    _getanduploadImage();
                  },
                  child: Container(
                    width: 170,
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.add),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Add your Profile")
                      ],
                    ),
                    color: Colors.orange,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _getanduploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //select Image
    image = (await _picker.getImage(source: ImageSource.gallery))!;
    var file = File(image.path);

    if (image != null) {
      //Upload to Firebase
      var snapshot = await _storage.ref().child(image.path).putFile(file);

      var downloadedUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadedUrl;
      });
      print('imageurl:' '$imageUrl');
    } else {
      print('No path Recieved');
    }
  }
}
