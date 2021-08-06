import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'display_notes.dart';
import 'signup.dart';

class SearchNotes extends StatefulWidget {
  SearchNotesState createState() => SearchNotesState();
}

class SearchNotesState extends State<SearchNotes> {
  FocusNode myFocusNote = FocusNode();

  String searchString = '';

  TextEditingController _searchStringController = TextEditingController();

  var child;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(children: [
      Container(
          margin: EdgeInsets.only(top: 40),
          child: TextField(
            onChanged: (value) {
              searchNotes();
              setState(() {
                searchString = _searchStringController.text;
                searchString = value.toLowerCase();
                return;
              });
            },
            controller: _searchStringController,
            cursorColor: Colors.grey,
            focusNode: myFocusNote,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            myFocusNote.hasFocus ? Colors.grey : Colors.grey)),
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                contentPadding: EdgeInsets.only(left: 70, top: 15),
                hintText: "Search your notes"),
          ))
    ]));
  }

  searchNotes() {
    Center(
      child: StreamBuilder<QuerySnapshot>(
          stream: (searchString == null || searchString.trim() == '')
              ? FirebaseFirestore.instance.collection("notes").snapshots()
              : FirebaseFirestore.instance
                  .collection('notes')
                  .where('title', isGreaterThanOrEqualTo: searchString)
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
                if (!snapshot.hasData) return Center(child: Text('error'));
                return Center(
                    child: SingleChildScrollView(
                  child: Wrap(
                      textDirection: TextDirection.ltr,
                      direction: Axis.horizontal,
                      //retrieve List<DocumentSnapshot> from snanpshot
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        return Stack(children: [
                          Container(
                              width: 320,
                              padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    document['title'],
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
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
                              ))
                        ]);
                      }).toList()),
                ));
            }
          }),
    );
  }
}
