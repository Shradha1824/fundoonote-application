import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/archive_notes.dart';
import 'package:flutter_application_1/screens/display_notes.dart';
import 'package:flutter_application_1/utils/firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apply_color_to_notes.dart';

// ignore: must_be_immutable
class AddNotePage extends StatefulWidget {

  @override
  AddNotePageState createState() => AddNotePageState();
}

class AddNotePageState extends State<AddNotePage> {
  //share data on local device in form of key and value use of sharedpreference
  late String userEmail; //to store email in sharedpreference
  FocusNode myFocusNode = new FocusNode();
  late Color _color = Colors.white;
  // late DateTime now = DateTime.now();
  // final dateFormate = DateFormat('dd-MM');
  late DateTime pickedDate = DateTime.now();
  late TimeOfDay pickedTime = TimeOfDay.now();
  late bool _pin = false;

  void initState() {
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
                                      onPressed: () async{
                                         await Database.addItem(
                                           title: _titlecontroller.text, 
                                           content: _contentcontroller.text,
                                           color: '$_color',
                                           archive: false,
                                           pin: true,
                                           userEmail: '$userEmail', 
                                           );
                                           Navigator.pop(context); 
                                      }),
                                  SizedBox(width: 190.0),
                                  IconButton(
                                      icon: Icon(_pin ? Icons.push_pin : Icons.push_pin_outlined,
                                      size: 25,
                                      color: Colors.black.withOpacity(0.7),
                                      ),
                                      onPressed: (){
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
                                                    onTap: () {
                                                      _showDialog(context);
                                                    }),
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
                                       var title = _titlecontroller.text;
                                       var content = _contentcontroller.text; 
                                       if (title.isEmpty && content.isEmpty){   
                                             Navigator.push(context, MaterialPageRoute(builder: 
                                             (context) => DisplayNotePage()));
                                      }else{
                                        var snackBar = SnackBar(
                                          backgroundColor: Colors.black,
                                    content: Row(
                                      children: [
                                        Text("Note Archive",
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                    ),
                                    SizedBox(width: 180,),
                                    InkWell(
                                      child:                                  
                                    Text("Undo",
                                    style: TextStyle(
                                      color: Colors.orange
                                    ),
                                    ),
                                    onTap: () async {
                                       await Database.addItem(
                                           title: _titlecontroller.text, 
                                           content: _contentcontroller.text,
                                           color: '$_color',
                                           archive: true,
                                           pin: false,
                                           userEmail: '$userEmail', 
                                           );
                                         Navigator.push(context, MaterialPageRoute(builder: 
                                        (context) => DisplayNotePage()));
                                    },                                
                                    )]),
                                    duration:
                                        Duration(seconds: 2, milliseconds: 250),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                        Database.addItem(
                                           title: _titlecontroller.text, 
                                           content: _contentcontroller.text,
                                           color: '$_color',
                                           archive: true,
                                           pin: false,
                                           userEmail: '$userEmail', 
                                           );
                                        () => Navigator.push(context, MaterialPageRoute(builder: 
                                        (context) => ArchivePage()));
                                      }
                                            }
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
                      fontSize: 18,
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
  // Show Dialog function
  void _showDialog(context) {
    // flutter defined function
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return alert dialog object
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                  height: 250.0,
                  width: 100.0,
                  child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                          children: [
                            SizedBox(width: 10,),
                            Text(
                              "Add Reminder",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black.withOpacity(0.9),
                                fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Column(
                              children: <Widget>[
                                SizedBox(height: 10, width: 10,),
                                ListTile(
                                  title: Text(
                                      "${pickedDate.day} - ${pickedDate.month}",
                                      style: TextStyle(fontSize: 18,
                                      color: Colors.black.withOpacity(0.9)
                                      ),
                                      ),
                                  trailing: Icon(Icons.keyboard_arrow_down,
                                  color: Colors.black87.withOpacity(0.7),
                                  ),
                                  onTap: _pickedDate,
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                ListTile(
                                  title: Text(
                                      "${pickedTime.hour}:${pickedTime.minute}",
                                      style: TextStyle(fontSize: 18,
                                      color: Colors.black.withOpacity(0.9),
                                      ),
                                      ),
                                  trailing: Icon(Icons.keyboard_arrow_down,
                                  color: Colors.black87.withOpacity(0.7)
                                  ),
                                  onTap: _pickedTime,
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                               // SizedBox(width: 150,),
                            FlatButton(
                              onPressed: (){
                            },
                             child: Text('Cancel',
                            style: TextStyle(fontSize: 17),
                            ),
                            ),
                            SizedBox(width: 70,),
                             FlatButton(
                              onPressed: (){
                                Navigator.pop(context);
                            },
                             child: Text('Save',
                            style: TextStyle(fontSize: 17),
                            ),
                            color: Colors.orange,
                            ),
                          ])]))));
        });
  }
  Future _pickedDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2022),
    ).then((value) {
      print(value)
      setState(() {
        pickedDate = value!;
      });
    });

    if (date == null)
      setState(() {
        pickedDate = date!;
      });
  }

  _pickedTime() async {
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
          setState(() {
            pickedTime = value!;
          });
        });
    
    if (time == null)
      setState(() {
        pickedTime = time!;
      });
  }
}