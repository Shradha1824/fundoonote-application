import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/base_screen.dart';
import 'package:hexcolor/hexcolor.dart';

class Login extends BaseScreen {
  LoginState crateLoginState() => new LoginState();
}

class LoginState extends BaseScreenState {
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
}
