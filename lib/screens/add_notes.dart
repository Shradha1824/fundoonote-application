import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/delete_notes.dart';
import 'package:flutter_application_1/screens/apply_color_to_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AddNotePage extends StatefulWidget {
  @override
  AddNotePageState createState() => AddNotePageState();
}

class AddNotePageState extends State<AddNotePage> {
  //share data on local device in form of key and value use of sharedpreference
  late SharedPreferences loginData; // create object for sharedPreference
  late String userEmail; //to store email in sharedpreference
  FocusNode myFocusNode = new FocusNode();
  late Color _color;

  void initState() {
    super.initState();
    getLoginData();
  }

  void getLoginData() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      userEmail = loginData.getString('userEmail')!;
      print('userEmail: $userEmail');
      print('_color: $_color');
    });
  }

  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _contentcontroller = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white10,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Material(
                            color: Colors.white10,
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
                                      onPressed: () {
                                        var title = _titlecontroller.text;
                                        var content = _contentcontroller.text;
                                        if (title.isEmpty && content.isEmpty) {
                                          print('Notes required');
                                          Navigator.pop(context);
                                        } else {
                                          print('Notes added');
                                          ref.add({
                                            'emailId': '$userEmail',
                                            'title': '${_titlecontroller.text}',
                                            'content':
                                                '${_contentcontroller.text}',
                                            'color': '$_color',
                                          }).whenComplete(
                                              () => Navigator.pop(context));
                                        }
                                      }),
                                  SizedBox(width: 190.0),
                                  IconButton(
                                      icon: Icon(
                                        Icons.push_pin_outlined,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {}),
                                  SizedBox(width: 2.0),
                                  IconButton(
                                      icon: Icon(
                                        Icons.add_alert_outlined,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {}),
                                  SizedBox(width: 2.0),
                                  IconButton(
                                      icon: Icon(
                                        Icons.archive_outlined,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ])))))),
        body: Container(
            color: Colors.white10,
            margin: EdgeInsets.only(bottom: 20),
            child: Container(
                child: Column(children: [
                  TextField(
                    controller: _titlecontroller,
                    focusNode: myFocusNode,
                    cursorColor: Colors.black54,
                    style: TextStyle(
                      height: 1,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal)),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: _contentcontroller,
                    cursorColor: Colors.black54,
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
            child: Container(
                color: Colors.white10,
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
                                          Colors.blue,
                                          Colors.red,
                                          Colors.yellow,
                                          Colors.pink,
                                          Colors.purple,
                                          Colors.orangeAccent,
                                          Colors.amber,
                                          Colors.cyan,
                                          Colors.brown,
                                          Colors.indigo,
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
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
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

  /* void colorNotes() {
    if (selectedIndex == null) {
      selectedIndex = widget.selectedIndex;
    }
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 100,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.only(top: 15, left: 15),
                  child: Container(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: colors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex == index
                                  ? colors[index]
                                  : Container();
                              print('s');
                            });
                            widget.onTap(index);
                          },
                          child: Container(
                              padding: EdgeInsets.all(8.0),
                              width: 50,
                              height: 50,
                              child: Container(
                                child: Center(
                                    child: selectedIndex == index
                                        ? Icon(Icons.done)
                                        : Container()),
                                decoration: BoxDecoration(
                                  color: colors[index],
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 2, color: Colors.grey),
                                ),
                              )),
                        );
                      },
                    ),
                  ),
                ),
              ));
        });
  }*/
}
