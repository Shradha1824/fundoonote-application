import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserLoginPage extends StatefulWidget {
  @override
  UserLoginPageState createState() => UserLoginPageState();
}

var reg;

void validation() {
  reg = '[^A-Za-z0-9+_.-]+@(.+)]';
  if (reg == '$_emailController') {
    print("login success");
  } else {
    print("unsuccess");
  }
}

TextEditingController _emailController = TextEditingController();

class UserLoginPageState extends State<UserLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: "EmailId",
            hintText: "Enter your email",
            border: OutlineInputBorder(),
          ),
        )),
      ),
    );
  }
}
