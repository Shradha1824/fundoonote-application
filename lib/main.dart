import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/add_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/add_notes.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          //'/signup': (context) => SignUp(),
          '/login': (context) => LoginScreen(),
          '/add_notes': (context) => AddNotePage(),
          '/note_appear_page': (context) => DisplayNotePage(),
          '/note_screen': (context) => AddNotePage(),
        });
  }
}
