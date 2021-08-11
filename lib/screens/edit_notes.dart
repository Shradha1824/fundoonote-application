import 'dart:developer';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/archive_notes.dart';
import 'package:flutter_application_1/screens/display_notes.dart';
import 'package:flutter_application_1/screens/user_login.dart';
import 'package:flutter_application_1/utils/firebase.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apply_color_to_notes.dart';
import 'delete_notes.dart';

// ignore: must_be_immutable
class EditNotePage extends StatefulWidget {
  DocumentSnapshot editDocument;
  late final String title;
  late final Color color;
  late final String documentId;

  EditNotePage({
    required this.editDocument,
  });
  @override
  EditNotePageState createState() => EditNotePageState();
}

class EditNotePageState extends State<EditNotePage> {
  //share data on local device in form of key and value use of sharedpreference
  late String userEmail; //to store email in sharedpreference
  FocusNode myFocusNode = new FocusNode();
  late Color _color = Colors.white;
  // late DateTime now = DateTime.now();
  // final dateFormate = DateFormat('dd-MM');
  late DateTime pickedDate = DateTime.now();
  late TimeOfDay pickedTime = TimeOfDay.now();
  bool _pin = false;
  bool _archive = false;

  var otherColor;

  bool _isDeleting = false;

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
    getLoginData();
  }

  void getLoginData() async {
    var loginData = await SharedPreferences.getInstance();
    setState(() {
      userEmail = loginData.getString('userEmail')!;
      print('userEmail: $userEmail');
      print('_color: $_color');
    });
  }

  TextEditingController _colorController = TextEditingController();
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _contentcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _color,
        appBar: AppBar(
            backwardsCompatibility: true,
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
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () async {
                                        await widget.editDocument.reference
                                            .update({
                                          //'docId': widget.documentId,
                                          'title': _titlecontroller.text,
                                          'content': _contentcontroller.text,
                                          'archive': _archive,
                                          'delete': _isDeleting,
                                          'pin': _pin,
                                          'color': '$_color',
                                          'userEmail': '$userEmail'
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayNotePage()));
                                      }),
                                  SizedBox(width: 190.0),
                                  IconButton(
                                    icon: Icon(
                                      _pin
                                          ? Icons.push_pin
                                          : Icons.push_pin_outlined,
                                      size: 25,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _pin = !_pin;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 2.0),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_alert_outlined,
                                      size: 25,
                                    ),
                                    color: Colors.black.withOpacity(0.7),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                ListTile(
                                                  leading: new Icon(
                                                      Icons.access_time),
                                                  title:
                                                      new Text('Later today'),
                                                  trailing: Text('18:00'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                ListTile(
                                                  leading: new Icon(
                                                      Icons.access_time),
                                                  title: new Text(
                                                      'Later tomorrow'),
                                                  trailing: Text('08:00'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                ListTile(
                                                    leading: new Icon(
                                                        Icons.access_time),
                                                    title: new Text(
                                                        'Choose a date & time'),
                                                    onTap: () {}),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                  SizedBox(width: 2.0),
                                  IconButton(
                                      icon: Icon(
                                        Icons.archive_outlined,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {
                                        setState(() {
                                          _archive = !_archive;
                                        });
                                        var title = _titlecontroller.text;
                                        var content = _contentcontroller.text;
                                        if (title.isEmpty && content.isEmpty) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DisplayNotePage()));
                                        } else {
                                          widget.editDocument.reference.update({
                                            //'docId': widget.documentId,
                                            'title': _titlecontroller.text,
                                            'content': _contentcontroller.text,
                                            'archive': _archive,
                                            'delete': _isDeleting,
                                            'pin': _pin,
                                            'color': '$_color',
                                            'userEmail': '$userEmail'
                                          });
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DisplayNotePage()));
                                        }
                                      }),
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
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.add_box_outlined,
                          size: 25,
                          color: Colors.black.withOpacity(0.7),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: new Icon(Icons.photo_camera),
                                      title: new Text('Take photo'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.crop_original),
                                      title: new Text('Add image'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.brush_outlined),
                                      title: new Text('Drawing'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.mic),
                                      title: new Text('Recording'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading:
                                          new Icon(Icons.check_box_outlined),
                                      title: new Text('Tick boxes'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: _color,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 120,
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: DisplayColor(
                                        onSelectedColor: (value) {
                                          print(value);
                                          setState(() {
                                            _color = value;
                                          });
                                        },
                                        availableColors: [
                                          Colors.white,
                                          Colors.blueAccent,
                                          Colors.redAccent,
                                          Colors.yellowAccent,
                                          Colors.pinkAccent,
                                          Colors.purpleAccent,
                                          Colors.orangeAccent,
                                          Colors.indigoAccent,
                                          Colors.cyan,
                                          Colors.brown,
                                          Colors.blueGrey,
                                          Colors.green,
                                        ],
                                        initialColor: Colors.white,
                                      ),
                                    ),
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.color_lens_outlined,
                            size: 25,
                            color: Colors.black.withOpacity(0.7),
                          )),
                      SizedBox(
                        width: 230,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          size: 25,
                          color: Colors.black.withOpacity(0.7),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                        leading: new Icon(Icons.delete_sharp),
                                        title: new Text('Delete'),
                                        onTap: () async {
                                          setState(() {
                                            _isDeleting = !_isDeleting;
                                          });
                                          {
                                            await widget.editDocument.reference
                                                .update({
                                              //'docId': widget.documentId,
                                              'title': _titlecontroller.text,
                                              'content':
                                                  _contentcontroller.text,
                                              'archive': _archive,
                                              'delete': _isDeleting,
                                              'pin': _pin,
                                              'color': '$_color',
                                              'userEmail': '$userEmail'
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DeleteNotesPage()));
                                            var snackBar = SnackBar(
                                                backgroundColor: Colors.black,
                                                content: Row(children: [
                                                  Text(
                                                    "Note Archive",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ]));
                                          }
                                        }),
                                    ListTile(
                                      leading: new Icon(Icons.filter_none),
                                      title: new Text('Make a copy'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.share),
                                      title: new Text('Send'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.person_add_alt),
                                      title: new Text('Collaborator'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(
                                        Icons.label,
                                      ),
                                      title: new Text('Labels'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      )
                    ]))));
  }
}
