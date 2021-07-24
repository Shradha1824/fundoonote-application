import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/notes_screen.dart';

class NoteAppearPage extends StatefulWidget {
  @override
  NoteAppearPageState createState() => NoteAppearPageState();
}

class NoteAppearPageState extends State<NoteAppearPage> {
  static const String routeName = '/note_appear_page';
  DrawerController _drawerController = DrawerController(
    child: NavigationDrawer(),
    alignment: DrawerAlignment.end,
  );
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
                        padding: const EdgeInsets.only(right: 20, left: 6),
                        child: Material(
                            color: Colors.white,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.menu,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {
                                        NavigationDrawer();
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
                                    ),
                                    onTap: () {},
                                  ),
                                ])))))),
        drawer: NavigationDrawer(),
        body: Center(child: Text("Notes you add appear here")),
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
            onTap: () {},
          ),
          createDrawerBodyItem(
            icon: Icons.notifications_outlined,
            text: 'Reminders',
            onTap: () {},
          ),
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
          createDrawerBodyItem(
            icon: Icons.delete_outline,
            text: 'Deleted',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.only(top: 0),
        padding: EdgeInsets.all(20),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 80.0,
              left: 16.0,
              child: Text("Google Keep",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
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
