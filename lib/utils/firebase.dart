import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('notes');

class Database {
  static String? userUid;

  static var document;

  static Future<void> addItem({
    required String title,
    required String content,
    required bool archive,
    required String color,
    required bool pin,
    required String userEmail,
  }) async {
    DocumentReference documentReference = _mainCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "content": content,
      "archive": archive,
      "color": color,
      "pin": pin,
      "userEmail": userEmail,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Note added in firebase"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String title,
    required String content,
    required bool archive,
    required String color,
    required bool pin,
    required String userEmail,
  }) async {
    DocumentReference documentReference = _mainCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "content": content,
      "archive": archive,
      "color": color,
      "pin": pin,
      "userEmail": userEmail,
    };

    await documentReference
        .update(data)
        .whenComplete(() => print("Note updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItem() {
    CollectionReference noteItemCollection =
        _mainCollection.doc(userUid).collection('notes');

    return noteItemCollection.snapshots();
  }
}
