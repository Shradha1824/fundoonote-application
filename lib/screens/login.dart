import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final databaseReference = FirebaseFirestore.instance;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
  }

  var users;
  void validate() async {
    if (formkey.currentState!.validate()) {
      print("Ok");
      //if(document.data.contains("emailid") == emailid.text){
    } else {
      print("Error");
    }
  }

  TextEditingController emailid = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Login"),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 30, right: 30, top: 15),
            child: Center(
                child: Form(
                    autovalidate: true,
                    key: formkey,
                    child: Column(children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                                width: 130.0,
                                height: 145.0,
                                child: Column(children: <Widget>[
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 25, bottom: 20)),
                                  Image.asset(
                                    'assets/images/keepnote.png',
                                  ),
                                  Text('Fundoo Notes',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.orange)),
                                ])),
                            Padding(padding: EdgeInsets.all(15)),
                            TextFormField(
                                controller: emailid,
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder()),
                                validator: MultiValidator([
                                  EmailValidator(
                                      errorText: "Please Enter Valid Email"),
                                  RequiredValidator(
                                      errorText: "Please Enter Email Id"),
                                ])),
                            Padding(padding: EdgeInsets.all(15)),
                            TextFormField(
                                controller: password,
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
                            RaisedButton(
                              onPressed: () {
                                validate();
                              },
                              child: Text('Submit'),
                              shape: StadiumBorder(),
                              color: Theme.of(context).primaryColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 120, vertical: 18),
                              textColor: Colors.black,
                            ),
                            Padding(padding: EdgeInsets.all(15)),
                            Text(
                              'Lost your Password?',
                            ),
                            Baseline(
                              baseline: 0,
                              baselineType: TextBaseline.alphabetic,
                            )
                          ],
                        ),
                      )
                    ])))));
  }
}
