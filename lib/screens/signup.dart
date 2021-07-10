import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/base_screen.dart';
import 'package:hexcolor/hexcolor.dart';

class Signup extends BaseScreen {
  SignupState createState() => SignupState();
}

class SignupState extends BaseScreenState {
  Widget getAppBar() {
    return AppBar(
      backgroundColor: HexColor('#446DFF'),
      title: Text(
        'Register to Fundoonote application',
        style: TextStyle(fontSize: 22.0, color: HexColor('#FFFFFF')),
      ),
      centerTitle: true,
    );
  }

  var _uInput;

  Widget getBody(BuildContext context) {
    return Center(
        child: Container(
            child: SizedBox(
      child: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(15),
              child: Column(children: <Widget>[
                Container(
                    margin: EdgeInsets.all(20.0),
                    width: 500.0,
                    height: 70.0,
                    padding: EdgeInsets.only(left: 16, right: 16, top: 11),
                    child: TextField(
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "First Name",
                            hintStyle:
                                TextStyle(fontSize: 15.0, color: Colors.black)),
                        keyboardType: TextInputType.text,
                        onChanged: (text) {
                          var input = double.tryParse(text);
                          if (input != null)
                            setState(() {
                              _uInput = input;
                            });
                        }),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.horizontal(),
                    )),
                Container(
                    margin: EdgeInsets.all(20.0),
                    width: 500.0,
                    height: 70.0,
                    padding: EdgeInsets.only(left: 16, right: 16, top: 11),
                    child: TextField(
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Last Name",
                            hintStyle:
                                TextStyle(fontSize: 15.0, color: Colors.black)),
                        keyboardType: TextInputType.text,
                        onChanged: (text) {
                          var input = double.tryParse(text);
                          if (input != null)
                            setState(() {
                              _uInput = input;
                            });
                        }),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.horizontal(),
                    )),
                Container(
                    margin: EdgeInsets.all(20.0),
                    width: 500.0,
                    height: 70.0,
                    padding: EdgeInsets.only(left: 16, right: 16, top: 11),
                    child: TextField(
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email Id",
                            hintStyle:
                                TextStyle(fontSize: 15.0, color: Colors.black)),
                        keyboardType: TextInputType.text,
                        onChanged: (text) {
                          var input = double.tryParse(text);
                          if (input != null)
                            setState(() {
                              _uInput = input;
                            });
                        }),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.horizontal(),
                    )),
                Container(
                    margin: EdgeInsets.all(20.0),
                    width: 500.0,
                    height: 70.0,
                    padding: EdgeInsets.only(left: 16, right: 16, top: 11),
                    child: TextField(
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle:
                                TextStyle(fontSize: 15.0, color: Colors.black)),
                        keyboardType: TextInputType.text,
                        onChanged: (text) {
                          var input = double.tryParse(text);
                          if (input != null)
                            setState(() {
                              _uInput = input;
                            });
                        }),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.horizontal(),
                    )),
                Container(
                    margin: EdgeInsets.all(20.0),
                    width: 500.0,
                    height: 70.0,
                    padding: EdgeInsets.only(left: 16, right: 16, top: 11),
                    child: TextField(
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Confirm Password",
                            hintStyle:
                                TextStyle(fontSize: 15.0, color: Colors.black)),
                        keyboardType: TextInputType.text,
                        onChanged: (text) {
                          var input = double.tryParse(text);
                          if (input != null)
                            setState(() {
                              _uInput = input;
                            });
                        }),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.horizontal(),
                    )),
              ])),
          Column(children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Submit'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                padding: MaterialStateProperty.all(
                    EdgeInsets.only(top: 20, left: 65, right: 65, bottom: 20)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 25)),
              ),
            )
          ]),
        ],
      ),
    )));
  }
}
