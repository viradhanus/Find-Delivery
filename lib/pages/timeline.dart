import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finddelivery/widgets/header.dart';
import 'package:finddelivery/widgets/progress.dart';
import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  CollectionReference userRef = Firestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: linearProgress(),
    );
  }

  getUser() async {
    final QuerySnapshot snapshot =
        await userRef
        .where("uid", isEqualTo: '123')
        .where("count",isEqualTo:6)
        .getDocuments();
    snapshot.documents.forEach((DocumentSnapshot doc) {
      print(doc.data);
    });
  }
}
