import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD:lib/screens/note_appear_page.dart
import 'package:flutter_application_1/screens/notes_screen.dart';
import 'package:flutter_application_1/screens/reminders.dart';
=======
import 'package:shared_preferences/shared_preferences.dart';

import 'add_notes.dart';
import 'login.dart';
import 'reminders.dart';
>>>>>>> development:lib/screens/desplay_notes.dart

class NoteAppearPage extends StatefulWidget {
  @override
  NoteAppearPageState createState() => NoteAppearPageState();
}

class NoteAppearPageState extends State<NoteAppearPage> {
  static const String routeName = '/note_appear_page';

  late SharedPreferences loginData; // create object for sharedPreference
  late String userEmail;
  late String title;
  late String content;

  var index;

  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      userEmail = loginData.getString('userEmail')!;
      print('userEmail: $userEmail');
    });
  }

  final ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white10,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 30),
                    height: 52,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 1.0,
                          )
                        ]),
                    child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 6),
                        child: Material(
                            color: Colors.white,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.menu,
                                        size: 30,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                  Expanded(
                                    child: TextField(
                                        decoration: InputDecoration.collapsed(
                                          hintText: "Search your notes",
                                        ),
                                        onChanged: (value) {}),
                                  ),
                                  InkWell(
                                    child: Icon(
                                      Icons.view_agenda_outlined,
                                      color: Colors.black.withOpacity(0.7),
                                      size: 25,
                                    ),
                                    onTap: () {
                                      icon:
                                      Icons.grid_view;
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.orange[400],
                                      radius: 15,
                                      child: Text(
                                        'S',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                    ),
                                    onPressed: () {
                                      loginData.setBool('login', true);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    },
                                  )
                                ])))))),
        drawer: NavigationDrawer(),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("notes").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError)
                    return Center(child: Text('Error: ${snapshot.error}'));
                  if (!snapshot.hasData)
                    return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Image.asset(
                            "assets/images/bulb[1].png",
                            width: 200,
                            height: 100,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Notes you add appear here"),
                        ]));
                  return Container(
                      child: SingleChildScrollView(
                    child: Wrap(
                        textDirection: TextDirection.ltr,
                        direction: Axis.horizontal,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          return Flexible(
                              flex: 2,
                              fit: FlexFit.loose,
                              child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        document['title'],
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        document['content'],
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                        maxLines: 10,
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )));
                        }).toList()),
                  ));
              }
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TitlePage()));
                  },
                  icon: Image.asset("assets/images/addIcon.png"))),
          foregroundColor: Colors.amber,
          focusColor: Colors.white10,
          hoverColor: Colors.green,
          backgroundColor: Colors.white,
          splashColor: Colors.tealAccent,
        ),
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.white,
            child: Container(
              width: 80,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.check_box_outlined,
                        size: 25,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        Icons.brush_outlined,
                        size: 25,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        Icons.mic,
                        size: 25,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        Icons.crop_original,
                        size: 25,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      onPressed: () {}),
                ],
              ),
            )));
  }
}

class NavigationDrawer extends StatelessWidget {
  var userEmail;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.lightbulb_outline,
            text: 'Notes',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NoteAppearPage()));
            },
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.notifications_outlined,
            text: 'Reminders',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Reminders()));
            },
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.add,
            text: 'Create new label',
            onTap: () {},
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.archive_outlined,
            text: 'Archive',
            onTap: () {},
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.delete_outline,
            text: 'Deleted',
            onTap: () {},
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget createDrawerHeader() {
    return Container(
      height: 100.0,
      padding: EdgeInsets.only(top: 5),
      child: DrawerHeader(
          child: Text("Fundoo Notes",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                //foreground: Paint()
                // shadows:
              ))),
    );
  }

  Widget createDrawerBodyItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(
              left: 8.0,
            ),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}