import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/note_appear_page.dart';
import 'package:flutter_application_1/screens/notes_screen.dart';
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
        initialRoute: '/signup',
        routes: {
          '/signup': (context) => SignUp(),
          '/login': (context) => LoginScreen(),
          '/note_screen': (context) => TitlePage(),
        });
    /*body: buildPages(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          selectedItemColor: Colors.orange,
          items: [
            BottomNavigationBarItem(
              icon: Text('Sign Up'),
              title: Text('Page'),
            ),
            BottomNavigationBarItem(
              icon: Text('Login'),
              title: Text('Page'),
            ),
          ],
          onTap: (int index) => setState(() => this.index = index),
        ),
      );

  Widget buildPages() {
    switch (index) {
      case 0:
        return NoteAppearPage();
      case 1:
        return LoginScreen();
      default:
        return Container();
    }
  }*/
  }
}
