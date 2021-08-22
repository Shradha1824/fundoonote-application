import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddLabel extends StatefulWidget {
  AddLabelState createState() => AddLabelState();
}

class AddLabelState extends State<AddLabel> {
  final docref = FirebaseFirestore.instance;

  bool icon = false;
  bool _string = false;

  TextEditingController textEditingController = TextEditingController();

  addLabel() async {
    DocumentReference labels1 = await docref.collection("labels1").add({
      "note": '${textEditingController.text}',
    }).whenComplete(() => print("label added"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(children: [
        Padding(padding: EdgeInsets.all(20)),
        TextField(
          onChanged: (text) {
            if (text.length > 1) {
              return null;
            }
          },
          decoration: InputDecoration(hintText: "Create your Label"),
          controller: textEditingController,
        ),
        SizedBox(
          height: 20,
        ),
        Row(children: [
          SizedBox(
            width: 10,
          ),
          InkWell(
              child: Icon(icon ? null : Icons.add),
              onTap: () {
                addLabel();
              }),
          SizedBox(
            width: 10,
          ),
          _string ? Text('') : Text("Create label")
        ])
      ])),
    );
  }

  validation(text) {
    setState(() {
      icon != icon;
      _string != _string;
    });
  }

  Widget iconText() {
    return Scaffold(
        body: Row(children: [
      IconButton(
        onPressed: () {},
        icon: Icon(icon ? null : Icons.add),
      ),
      _string ? Text('') : Text("Create label")
    ]));
  }
}
