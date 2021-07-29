import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:flutter_application_1/screens/notes_screen.dart';
>>>>>>> development
import 'note_appear_page.dart';

class Reminders extends StatelessWidget {
  static const String routeName = '/reminders';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white10,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
<<<<<<< HEAD
=======
                    // margin: EdgeInsets.only(left: 15, right: 15, bottom: 30),
>>>>>>> development
                    child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Material(
                            color: Colors.white10,
                            child: Row(
<<<<<<< HEAD
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
=======
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
>>>>>>> development
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.menu,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                  Text(
                                    "Reminders",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(width: 140.0),
                                  IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
<<<<<<< HEAD
                                      onPressed: () {}),
=======
                                      onPressed: () {
                                        TextFormField(
                                            decoration:
                                                InputDecoration.collapsed(
                                              hintText: "Search your notes",
                                            ),
                                            onChanged: (value) {});
                                      }),
>>>>>>> development
                                  SizedBox(width: 2.0),
                                  IconButton(
                                      icon: Icon(
                                        Icons.view_agenda_outlined,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {}),
                                  SizedBox(width: 2.0)
                                ])))))),
        drawer: NavigationDrawer(),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/images/reminder[1].png",
<<<<<<< HEAD
            width: 120,
            height: 120,
=======
            width: 100,
            height: 100,
>>>>>>> development
          ),
          SizedBox(
            height: 15,
          ),
          Text("Notes with upcoming reminders appear here"),
        ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Builder(
              builder: (context) => IconButton(
<<<<<<< HEAD
                  onPressed: () {},
=======
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TitlePage()));
                  },
>>>>>>> development
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
