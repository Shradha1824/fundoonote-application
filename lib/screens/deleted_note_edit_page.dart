import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/delete_notes.dart';
import 'package:flutter_application_1/screens/edit_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'display_notes.dart';

class EditDeleteNotesPage extends StatefulWidget {
  DocumentSnapshot editDocument;
  late final String title;

  EditDeleteNotesPage({
    required this.editDocument,
  });

  EditDeleteNotesPageState createState() => EditDeleteNotesPageState();
}

class EditDeleteNotesPageState extends State<EditDeleteNotesPage> {
  FocusNode myFocusNode = new FocusNode();
  late Color _color = Colors.white;
  late String userEmail;

  var document;

  void initState() {
    _titlecontroller = TextEditingController(
      text: widget.editDocument['title'],
    );
    _contentcontroller = TextEditingController(
      text: widget.editDocument['content'],
    );
    String testingColorString = widget.editDocument['color'].toString();
    String valueString = testingColorString.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    Color otherColor = new Color(value);
    _color = otherColor;
    super.initState();
  }

  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _contentcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: _color,
        appBar: AppBar(
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: _color),
            backgroundColor: _color,
            elevation: 0.0,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Material(
                            color: _color,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: 25,
                                    ),
                                    color: Colors.black.withOpacity(0.7),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ])))))),
        body: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Container(
                child: Column(children: [
                  TextField(
                    controller: _titlecontroller,
                    focusNode: myFocusNode,
                    cursorColor: Colors.black54,
                    maxLines: 1,
                    style: TextStyle(
                      height: 1,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(
                          color: Colors.black26,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: _contentcontroller,
                    cursorColor: Colors.black54,
                    maxLines: 10,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Note',
                        hintStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                        helperStyle: TextStyle(
                          fontSize: 25,
                        )),
                  ),
                ]),
                padding: EdgeInsets.all(20))),
        bottomNavigationBar: BottomAppBar(
            color: _color,
            child: Container(
                margin: EdgeInsets.all(15),
                color: _color,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
                    Icons.add_box_outlined,
                    size: 25,
                    color: Colors.black45,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.color_lens_outlined,
                    size: 25,
                    color: Colors.black45,
                  ),
                  SizedBox(
                    width: 242,
                  ),
                  IconButton(
                      icon:
                          Icon(Icons.more_vert, size: 25, color: Colors.black),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                        leading: new Icon(
                                          Icons.restore_outlined,
                                          color: Colors.black,
                                        ),
                                        title: new Text('Restore'),
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditNotePage(
                                                        editDocument:
                                                            widget.editDocument,
                                                      )));
                                          var snackBar = SnackBar(
                                            backgroundColor: Colors.black,
                                            content: Row(children: [
                                              Text(
                                                "Note restored",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 180,
                                              ),
                                              InkWell(
                                                child: Text("Undo",
                                                    style: TextStyle(
                                                        color: Colors.orange)),
                                              ),
                                            ]),
                                            duration: Duration(
                                                seconds: 2, milliseconds: 250),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }),
                                    ListTile(
                                        leading: new Icon(
                                          Icons.delete_forever,
                                          color: Colors.black87,
                                        ),
                                        title: new Text('Delete forever'),
                                        onTap: () {
                                          _showDialog();
                                        })
                                  ]);
                            });
                      })
                ]))));
  }

  void deleteForever() async {
    await widget.editDocument.reference.delete();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DeleteNotesPage()));
  }

  _showDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal()),
              content: Container(
                  height: 80,
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delete this note forever?",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 16),
                              )),
                          TextButton(
                              onPressed: () {
                                deleteForever();
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 16),
                              )),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      )
                    ],
                  )),
            );
          });
        });
  }
}
