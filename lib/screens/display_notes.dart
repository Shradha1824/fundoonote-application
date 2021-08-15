import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/edit_notes.dart';
import 'package:flutter_application_1/screens/search_notes.dart';
import 'package:flutter_application_1/utils/upload_pick.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_notes.dart';
import 'archive_notes.dart';
import 'delete_notes.dart';
import 'login.dart';
import 'reminders.dart';

class DisplayNotePage extends StatefulWidget {
  var document;

  var items;

  @override
  DisplayNotePageState createState() => DisplayNotePageState();
}

class DisplayNotePageState extends State<DisplayNotePage> {
  late SharedPreferences loginData; // create object for sharedPreference
  late String userEmail;

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('notes');

  late Color _color = Colors.white;
  bool archive = false;
  late bool _pin;
  bool _gridView = false;

  @override
  void initState() {
    super.initState();
    getNotes();
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

  Future<void> getNotes() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backwardsCompatibility: false,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.white10),
            backgroundColor: Colors.white10,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                    margin: EdgeInsets.only(
                        top: 10, left: 15, right: 15, bottom: 12),
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
                                        NavigationDrawer();
                                      }),
                                  SizedBox(
                                    width: 0,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateNewLabel()));
                                      },
                                      child: Text(
                                        "Search your notes",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 55,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      _gridView
                                          ? Icons.grid_view_outlined
                                          : Icons.view_agenda_outlined,
                                      color: Colors.black.withOpacity(0.7),
                                      size: 25,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _gridView = !_gridView;
                                      });
                                    },
                                  ),
                                  IconButton(
                                      icon: CircleAvatar(
                                        backgroundColor: Colors.grey[400],
                                        radius: 15,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UploadedPickPage()));
                                        // loginData.setBool('login', true);
                                        // Navigator.pushReplacement(
                                        //    context,
                                        //   MaterialPageRoute(
                                        //      builder: (context) =>
                                      } //         LoginScreen()));
                                      ),
                                ])))))),
        drawer: NavigationDrawer(),
        body: changeView(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddNotePage()));
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

  Widget listView() {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        //pass 'Stream<QuerySnapshot>' to stream
        stream: FirebaseFirestore.instance
            .collection("notes")
            .where("archive", isEqualTo: false)
            .where("delete", isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              String testingColor = doc['color'].toString();
              print(testingColor);
              String valueString = testingColor.split('(0x')[1].split(')')[0];
              int value = int.parse(valueString, radix: 16);
              Color otherColor = new Color(value);
              print(otherColor);
              return Padding(
                  padding: EdgeInsets.all(0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditNotePage(editDocument: doc)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: otherColor,
                            border: Border.all(
                                color: Colors.black54.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 1,
                                  spreadRadius: 0.0,
                                  offset: Offset(2.0, 2.0))
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc['title'],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                maxLines: 5,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                doc['content'],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                                maxLines: 10,
                              ),
                            ]),
                      )));
            }).toList(),
          );
        },
      ),
    );
  }

  Widget gridView() {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        //pass 'Stream<QuerySnapshot>' to stream
        stream: FirebaseFirestore.instance
            .collection("notes")
            .where("archive", isEqualTo: false)
            .where("delete", isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: snapshot.data!.docs.map((doc) {
              String testingColor = doc['color'].toString();
              print(testingColor);
              String valueString = testingColor.split('(0x')[1].split(')')[0];
              int value = int.parse(valueString, radix: 16);
              Color otherColor = new Color(value);
              print(otherColor);
              return Padding(
                  padding: EdgeInsets.all(0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditNotePage(editDocument: doc)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: otherColor,
                            border: Border.all(
                                color: Colors.black54.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 1,
                                  spreadRadius: 0.0,
                                  offset: Offset(2.0, 2.0))
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc['title'],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                maxLines: 5,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                doc['content'],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                                maxLines: 10,
                              ),
                            ]),
                      )));
            }).toList(),
          );
        },
      ),
    );
  }

  changeView() {
    if (_gridView == false) {
      return gridView();
    } else {
      return listView();
    }
  }
}

class NavigationDrawer extends StatelessWidget {
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
                  MaterialPageRoute(builder: (context) => DisplayNotePage()));
            },
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.notifications_outlined,
            text: 'Reminders',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReminderPage()));
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
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ArchivePage()));
            },
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.delete_outline,
            text: 'Deleted',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DeleteNotesPage()));
            },
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
