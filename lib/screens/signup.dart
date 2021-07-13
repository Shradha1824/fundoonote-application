import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/custom_textfield.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            buildText('First Name'),
            buildTextMethod(),
            buildText('Last Name'),
            buildTextMethod(),
            buildText('Email Id'),
            buildTextMethod(),
            buildText('Password'),
            buildTextMethod(),
            buildText('Confirm Password'),
            buildTextMethod(),
            const SizedBox(height: 24),
            CustomTextField(
              text: 'Register',
              onClicked: () {
                print('Sign Up');
              },
            ),
          ],
        ),
      );

  Widget buildText(String text) => Container(
        margin: EdgeInsets.fromLTRB(0, 24, 0, 8),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );

  Widget buildTextMethod() => TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(),
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(),
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
        ),
      );
}
