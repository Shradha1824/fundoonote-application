import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('notes');
final CollectionReference _collectionReference = _firestore.collection('users');
final CollectionReference _collectionref = _firestore.collection('labels');

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
    required bool deletenote,
    //required String label,
  }) async {
    DocumentReference documentReference = _mainCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "content": content,
      "archive": archive,
      "color": color,
      "pin": pin,
      "userEmail": userEmail,
      "delete": deletenote,
      // "label": label,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Note added in firebase"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String docId,
    required String title,
    required String content,
    required bool archive,
    required String color,
    required bool pin,
    required String userEmail,
  }) async {
    DocumentReference documentReference = _mainCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "docId": docId,
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

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}

Future<void> updateUrl({
  required String docId,
  required String image,
}) async {
  DocumentReference docref = _collectionReference.doc(docId);

  Map<String, dynamic> data = <String, dynamic>{
    //"docId": docId,
    "image": image,
  };
  await docref
      .update(data)
      .whenComplete(() => print("Note updated in the database"))
      .catchError((e) => print(e));
}

Future<void> addLabel(
    {required String label, required String userEmail}) async {
  DocumentReference documentReference = _collectionref.doc();

  Map<String, dynamic> data = <String, dynamic>{
    "label": label,
    "userEmail": userEmail,
  };

  await documentReference
      .set(data)
      .then((value) => null)
      .whenComplete(() => print("New label added"))
      .catchError((e) => e);
}

Future<void> arrayaddLabel({required String label, required List docId}) async {
  DocumentReference documentReference = _collectionref.doc('docId');
  DocumentSnapshot<Object?> doc = await documentReference.get();
  List labels = doc['label'];
  Object? event;
  if (labels.contains(event) == true) {
    documentReference.update({
      'label': FieldValue.arrayUnion([event])
    });
  }
}
