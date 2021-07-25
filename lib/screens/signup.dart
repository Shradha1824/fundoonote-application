import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final databaseReference = FirebaseFirestore.instance;
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 30, right: 30, top: 15),
        child: Center(
          child: Form(
            autovalidate: true,
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: ListView(),
                ),
                Padding(padding: EdgeInsets.all(15)),
                TextFormField(
                  controller: _firstname,
                  decoration: InputDecoration(
                      labelText: 'First Name', border: OutlineInputBorder()),
                  validator: textValidate,
                ),
                Padding(padding: EdgeInsets.all(15)),
                TextFormField(
                  controller: _lastname,
                  decoration: InputDecoration(
                      labelText: 'Last Name', border: OutlineInputBorder()),
                  validator: textValidate,
                ),
                Padding(padding: EdgeInsets.all(15)),
                TextFormField(
                    controller: _emailid,
                    decoration: InputDecoration(
                        labelText: 'Email Id', border: OutlineInputBorder()),
                    validator: MultiValidator([
                      EmailValidator(errorText: "Please enter valid Email"),
                      RequiredValidator(errorText: "Valid Email Expected"),
                    ])),
                Padding(padding: EdgeInsets.all(15)),
                TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                        labelText: 'Password', border: OutlineInputBorder()),
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
                Text(
                  'By clicking the Sign Up button, you agree to our Terms & Condition, and Privacy Policy',
                  textAlign: TextAlign.center,
                ),
                Padding(padding: EdgeInsets.all(15)),
                InkWell(splashColor: Colors.greenAccent),
                RaisedButton(
                  onPressed: () {
                    validate();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text('Submit'),
                  shape: StadiumBorder(),
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 18),
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
