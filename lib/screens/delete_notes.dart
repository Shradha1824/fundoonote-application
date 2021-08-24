import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'add_notes.dart';
import 'deleted_note_edit_page.dart';
import 'edit_notes.dart';
import 'home.dart';

class DeleteNotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backwardsCompatibility: false,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.white),
            backgroundColor: Colors.white10,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(2, 5, 2, 10),
                        child: Material(
                            color: Colors.white10,
                            child: Row(
                                // mainAxisSize: MainAxisSize.max,
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.menu,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {
                                        NavigationDrawer();
                                      }),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Deleted",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(width: 200.0),
                                  IconButton(
                                      icon: Icon(
                                        Icons.more_vert,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {}),
                                ])))))),
        drawer: NavigationDrawer(),
        body: StreamBuilder<QuerySnapshot>(
            //pass 'Stream<QuerySnapshot>' to stream
            stream: FirebaseFirestore.instance
                .collection("notes")
                .where("delete", isEqualTo: true)
                .snapshots(),
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
                  SizedBox(
                    height: 10,
                  );
                  return SingleChildScrollView(
                    child: Wrap(
                        textDirection: TextDirection.ltr,
                        direction: Axis.horizontal,
                        //retrieve List<DocumentSnapshot> from snanpshot
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          String testingColor = document['color'].toString();
                          print(testingColor);
                          String valueString =
                              testingColor.split('(0x')[1].split(')')[0];
                          int value = int.parse(valueString, radix: 16);
                          Color otherColor = new Color(value);
                          print(otherColor);
                          return Stack(children: [
                            InkWell(
                              child: Container(
                                  width: 360,
                                  padding: EdgeInsets.all(15),
                                  margin: EdgeInsets.fromLTRB(15, 10, 10, 15),
                                  decoration: BoxDecoration(
                                      color: otherColor,
                                      border: Border.all(color: Colors.black38),
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 1,
                                            spreadRadius: 0.0,
                                            offset: Offset(2.0, 2.0))
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        document['title'],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 5,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        document['content'],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                        maxLines: 10,
                                      ),
                                    ],
                                  )),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditDeleteNotesPage(
                                              editDocument: document,
                                            )));
                              },
                            ),
                          ]);
                        }).toList()),
                  );
              }
            }));
  }
}
