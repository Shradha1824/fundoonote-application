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

  Widget getBody(BuildContext context) {
    return Center();
  }
}
