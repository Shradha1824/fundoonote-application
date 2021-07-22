import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteAppearPage extends StatefulWidget {
  @override
  NoteAppearPageState createState() => NoteAppearPageState();
}

class NoteAppearPageState extends State<NoteAppearPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.view_agenda),
                )
              ],
              title: Text(
                "Search your notes",
              ),
              backgroundColor: Colors.grey,
            ),
            body: Center(child: Text("Notes you add appear here")),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.add,
              ),
              foregroundColor: Colors.amber,
              focusColor: Colors.white10,
              hoverColor: Colors.green,
              backgroundColor: Colors.white,
              splashColor: Colors.tealAccent,
            ),
            bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                child: Container(
                  width: 80,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.check_box_outlined,
                            size: 25,
                          ),
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(
                            Icons.brush,
                            size: 25,
                          ),
                          onPressed: () {}),
                      //SizedBox(width: 0), // The dummy child
                      IconButton(
                          icon: Icon(
                            Icons.mic,
                            size: 25,
                          ),
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(
                            Icons.crop_original,
                            size: 25,
                          ),
                          onPressed: () {}),
                    ],
                  ),
                ))));
  }
}
