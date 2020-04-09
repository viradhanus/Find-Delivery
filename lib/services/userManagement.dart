// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:finddelivery/pages/home_temp.dart';
// import 'package:flutter/material.dart';

// class UserManagement {
//   storeNewUser(user, context) {
//     Firestore.instance.collection('/users').add({
//       'email': user.email,
//       'uid': user.uid
//     }).then((value) {
//       Navigator.of(context).pop();
//       Navigator.of(context).pushReplacementNamed(HomeTemp.id);
//     }).catchError((e) {
//       print(e);
//     });
//   }
// }
