import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'login.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool rememberMe = false;

  final databaseReference = FirebaseFirestore.instance;
  var showErrorMessage = false;

  void validate() async {
    if (formkey.currentState!.validate()) {
      print("Ok");

      DocumentReference users =
          await databaseReference.collection('users').add({
        'firstName': '${_firstname.text}',
        'lastName': '${_lastname.text}',
        'emailId': '${_emailid.text}',
        'password': '${_password.text}',
      });
      print(users.id);
    } else {
      print("Error");
    }
  }

  String? textValidate(value) {
    if (value.isEmpty) {
      return "Text Expected";
    } else {
      return null;
    }
  }

  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _emailid = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sign Up"),
          backgroundColor: Color(0xFFFFA726),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 30, right: 30, top: 15),
            child: Center(
                child: Form(
                    autovalidate: true,
                    key: formkey,
                    child: Column(children: [
                      Padding(padding: EdgeInsets.all(20)),
                      TextFormField(
                        controller: _firstname,
                        decoration: InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder()),
                        validator: textValidate,
                      ),
                      Padding(padding: EdgeInsets.all(15)),
                      TextFormField(
                        controller: _lastname,
                        decoration: InputDecoration(
                            labelText: 'Last Name',
                            border: OutlineInputBorder()),
                        validator: textValidate,
                      ),
                      Padding(padding: EdgeInsets.all(15)),
                      TextFormField(
                          controller: _emailid,
                          decoration: InputDecoration(
                              labelText: 'Email Id',
                              border: OutlineInputBorder()),
                          validator: MultiValidator([
                            EmailValidator(
                                errorText: "Please enter valid Email"),
                            RequiredValidator(
                                errorText: "Valid Email Expected"),
                          ])),
                      Padding(padding: EdgeInsets.all(15)),
                      TextFormField(
                          controller: _password,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder()),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter Password";
                            }
                            if (val.length < 6) {
                              return "Please enter valid Password";
                            }
                          }),
                      Padding(padding: EdgeInsets.all(15)),
                      TextFormField(
                          controller: _confirmpassword,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              border: OutlineInputBorder()),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter Re-Password";
                            }
                            if (_password.text != _confirmpassword.text) {
                              return "Password do not Match";
                            }
                          }),
                      Padding(padding: EdgeInsets.all(15)),
                      Container(
                          child: Row(children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.black,
                          ),
                          child: Checkbox(
                            focusColor: Colors.lightBlue,
                            activeColor: Colors.orange,
                            value: rememberMe,
                            onChanged: (newValue) {
                              setState(() => rememberMe = (newValue)!);
                            },
                          ),
                        ),
                        showErrorMessage
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                      "Please accept the terms and conditions to proceed.."),
                                ),
                              )
                            : Container(),
                        RichText(
                          text: TextSpan(
                              text: "I agree all statements in\t",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Terms of service',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 15),
                                )
                              ]),
                        )
                      ])),
                      Padding(padding: EdgeInsets.all(15)),
                      RaisedButton(
                          child: Text('Sign Up'),
                          color: Colors.orange[400],
                          padding: EdgeInsets.symmetric(
                              horizontal: 140, vertical: 20),
                          onPressed: () {
                            validate();
                            textValidate("");
                            if (rememberMe != true)
                              setState(() => showErrorMessage = true);
                            else {
                              setState(() => showErrorMessage = false);
                            }

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          })
                    ])))));
  }
}
