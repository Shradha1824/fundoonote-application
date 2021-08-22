import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class FirebaseNotes extends StatefulWidget {
  FirebaseNotesState createState() => FirebaseNotesState();
}

class FirebaseNotesState extends State<FirebaseNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                margin: EdgeInsets.all(10),
                width: 200,
                height: 100,
                child: Card(
                    elevation: 8,
                    child: Column(children: [
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "This is my note",
                        textAlign: TextAlign.center,
                      ),
                    ])))));
  }
}
