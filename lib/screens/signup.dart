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
        'Welcome to fundonote application',
        style: TextStyle(fontSize: 22.0, color: HexColor('#FFFFFF')),
      ),
      centerTitle: true,
    );
  }

  var _userInput;

  Widget getBody(BuildContext context) {
    return Center(
        child: Container(
            child: SizedBox(
                child: ListView(children: <Widget>[
      Container(
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
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black)),
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  var input = double.tryParse(text);
                  if (input != null)
                    setState(() {
                      _userInput = input;
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
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black)),
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  var input = double.tryParse(text);
                  if (input != null)
                    setState(() {
                      _userInput = input;
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
                    hintText: "EmailId",
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black)),
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  var input = double.tryParse(text);
                  if (input != null)
                    setState(() {
                      _userInput = input;
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
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black)),
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  var input = double.tryParse(text);
                  if (input != null)
                    setState(() {
                      _userInput = input;
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
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black)),
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  var input = double.tryParse(text);
                  if (input != null)
                    setState(() {
                      _userInput = input;
                    });
                }),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.horizontal(),
            ))
      ]))
    ]))));
  }
}
