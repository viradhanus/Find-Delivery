import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String homeNumber;
  String street1;
  String street2;
  String city;

  User(
      {this.id,
      this.name,
      this.homeNumber,
      this.street1,
      this.street2,
      this.city});

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      name: doc['name'],
      homeNumber: doc['homeNumber'],
      street1: doc['street1'],
      street2: doc['street2'],
      city: doc['city'],
    );
  }
}
