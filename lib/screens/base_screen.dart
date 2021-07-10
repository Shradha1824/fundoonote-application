import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  BaseScreenState createState() => new BaseScreenState();
}

class BaseScreenState extends State<BaseScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    return Text('Page not implemented');
  }

  getAppBar() {}
}
