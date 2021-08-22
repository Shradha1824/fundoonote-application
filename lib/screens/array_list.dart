import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class _DropdownWithLabel extends StatefulWidget {
  final String label;
  final List<String> dropdownItems;
  _DropdownWithLabel(this.label, this.dropdownItems);
  @override
  State<StatefulWidget> createState() =>
      _DropdownWithLabelState(label, dropdownItems);
}

class _DropdownWithLabelState extends State {
  final String label;
  final List<String> dropdownItems;
  String? selectedItem;
  _DropdownWithLabelState(this.label, this.dropdownItems) {
    selectedItem = dropdownItems.first;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('labels').snapshots(),
            builder: (context, snapshot) {
              return _DropdownWithLabel(
                  'Label', snapshot.data!.docs.map((doc) => doc.id).toList());
            }));
  }
}
