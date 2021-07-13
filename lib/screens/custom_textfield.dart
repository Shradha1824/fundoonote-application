import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const CustomTextField({
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) => RaisedButton(
        child: Text(
          text,
          style: TextStyle(fontSize: 15),
        ),
        shape: StadiumBorder(),
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textColor: Colors.black,
        onPressed: onClicked,
      );
}
