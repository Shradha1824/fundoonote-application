import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/firebase.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusEmail = new FocusNode();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final databaseReference = FirebaseFirestore.instance;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');

  late bool _passwordVisible;

  late SharedPreferences loginData; //create object for sharedPreference
  late bool newUser;

  String? _image;

  @override
  void initState() {
    super.initState();
    getData();
    _passwordVisible = false;
    check_if_already_login();
  }

  void unvisiblePass(TapDownDetails details) {
    setState(() => _passwordVisible = false);
  }

  void visiblePass(TapDownDetails details) {
    setState(() => _passwordVisible = true);
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
  }

  void validate() async {
    if (formkey.currentState!.validate()) {
      print("Ok");
    } else {
      print("Error");
    }
  }

  TextEditingController _emailidController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Login',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Color(0xFFFFA726),
          //iconTheme: IconThemeData(color: Colors.orange),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 30, right: 30, top: 15),
            child: Center(
                child: Form(
                    autovalidate: true,
                    key: formkey,
                    child: Column(children: [
                      Container(
                          child: Column(children: [
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
                        Padding(padding: EdgeInsets.all(10)),
                        TextFormField(
                            controller: _emailidController,
                            cursorColor: Colors.orange,
                            focusNode: myFocusEmail,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your email',
                              labelStyle: TextStyle(color: Colors.orange),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(
                                Icons.email,
                                color: Colors.orange,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: myFocusNode.hasFocus
                                          ? Colors.orange
                                          : Colors.orange)),
                            ),
                            validator: MultiValidator([
                              EmailValidator(
                                  errorText: "Please Enter Valid Email"),
                              RequiredValidator(
                                  errorText: "Please Enter Email Id"),
                            ])),
                        Padding(padding: EdgeInsets.all(15)),
                        TextFormField(
                            autofocus: false,
                            obscureText: true,
                            controller: _passwordController,
                            cursorColor: Colors.orange,
                            focusNode: myFocusNode,
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.orange),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: myFocusNode.hasFocus
                                          ? Colors.orange
                                          : Colors.orange)),
                              suffixIcon: GestureDetector(
                                onTapDown: unvisiblePass,
                                child: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.orange),
                              ),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter Password";
                              }
                              if (val.length < 6) {
                                return "Please enter valid Password";
                              }
                            }),
                        Padding(padding: EdgeInsets.all(10)),
                        Container(
                            margin: EdgeInsets.only(left: 200, right: 7),
                            child: Text(
                              "Forgot Password?",
                              textDirection: TextDirection.ltr,
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 15),
                            )),
                        Padding(padding: EdgeInsets.all(10)),
                        RaisedButton(
                          child: Text(
                            'Submit',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black87),
                          ),
                          color: Colors.orange[400],
                          padding: EdgeInsets.symmetric(
                              horizontal: 140, vertical: 20),
                          onPressed: () {
                            validate();
                            String userEmail = _emailidController.text;
                            String userPassword = _passwordController.text;
                            FirebaseFirestore.instance
                                .collection('users')
                                .get()
                                .then((QuerySnapshot querySnapshot) {
                              querySnapshot.docs.forEach((docs) {
                                print(docs["emailId"]);
                                print(docs.id);
                                print(docs["password"]);
                                if ((docs["emailId"] ==
                                        '${_emailidController.text}') &&
                                    (docs["password"] ==
                                        '${_passwordController.text}')) {
                                  print("Login is Successfully");
                                  var snackBar = SnackBar(
                                    content: Text(docs.reference.id),
                                    duration:
                                        Duration(seconds: 1, milliseconds: 250),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  if (userEmail != '' && userPassword != '') {
                                    print('Successfull');
                                    //print(userEmail);
                                    //making use of object create one instance
                                    loginData.setBool('login', false);

                                    loginData.setString('userEmail', userEmail);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DisplayNotePage()));
                                    FirebaseFirestore.instance
                                        .collection('notes')
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      querySnapshot.docs.forEach((docs) {
                                        if (docs['emailId'] == userEmail) {
                                          print('object');
                                        }
                                      });
                                    });
                                  } else {
                                    print("First you need to Register");
                                    var snackBar = SnackBar(
                                      content: Text(
                                          "your emailId and password is not matching"),
                                      duration: Duration(
                                          seconds: 1, milliseconds: 250),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }
                              });
                            });
                          },
                        ),
                        Padding(padding: EdgeInsets.all(15)),
                        RichText(
                          text: TextSpan(
                              text: "Dont\'t have an account?\t",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 15),
                                  //  recognizer: TapGestureRecognizer().onTap = (){
                                  //    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                                  // }
                                )
                              ]),
                        ),
                      ]))
                    ])))));
  }

  void check_if_already_login() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool('login') ?? true);

    print(newUser);
    if (newUser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DisplayNotePage()));
    }
  }
}
