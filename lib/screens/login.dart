import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  String password = '';
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) => Center(
        child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            buildImage(),
            buildEmail(),
            const SizedBox(height: 24),
            buildPassword(),
            const SizedBox(height: 24),
            CustomTextField(text: 'Submit', onClicked: () {}),
          ],
        ),
      );

  Widget buildImage() => Container(
        child: Column(
          children: [
            Container(
                width: 130.0,
                height: 145.0,
                child: Card(
                    margin:
                        EdgeInsets.only(top: 20, bottom: 30, left: 5, right: 5),
                    elevation: 5,
                    child: Column(children: <Widget>[
                      Padding(padding: EdgeInsets.all(5)),
                      Image.asset(
                        'assets/images/keepnote.png',
                      ),
                      Text('Fundoo Notes',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange)),
                    ]))),
          ],
        ),
      );

  Widget buildEmail() => TextField(
        controller: emailController,
        decoration: InputDecoration(
          hintText: 'email',
          labelText: 'Email',
          prefixIcon: Icon(Icons.mail),
          suffixIcon: emailController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => emailController.clear(),
                ),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        autofocus: true,
      );

  Widget buildPassword() => TextField(
        onChanged: (value) => setState(() => this.password = value),
        onSubmitted: (value) => setState(() => this.password = value),
        decoration: InputDecoration(
          hintText: 'Your Password...',
          labelText: 'Password',
          errorText: 'Password is wrong',
          suffixIcon: IconButton(
            icon: isPasswordVisible
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
            onPressed: () =>
                setState(() => isPasswordVisible = !isPasswordVisible),
          ),
          border: OutlineInputBorder(),
        ),
        obscureText: isPasswordVisible,
      );
}
