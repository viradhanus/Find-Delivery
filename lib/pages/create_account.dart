import 'package:finddelivery/widgets/header.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  final String dispName;

  CreateAccount({Key key, @required this.dispName}) : super(key: key);
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();

  String name;
  String homeNumber;
  String street1;
  String street2;
  String city;

  submit() {
    _formKey.currentState.save();

    UserInfoDetails userInfoDetails =
        new UserInfoDetails(name, homeNumber, street1, street2, city);

    Navigator.pop(context, userInfoDetails);
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: header(context, titleText: "Set up your profile"),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: TextFormField(
                    onSaved: (val) => name = val,
                    initialValue: widget.dispName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      labelStyle: TextStyle(fontSize: 15.0),
                      hintText: "Enter your name",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Text(
                    "Delivery Address",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: TextFormField(
                    onSaved: (hn) => homeNumber = hn,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Home Number",
                      labelStyle: TextStyle(fontSize: 15.0),
                      hintText: "Enter your home number",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: TextFormField(
                    onSaved: (strN1) => street1 = strN1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Street Name",
                      labelStyle: TextStyle(fontSize: 15.0),
                      hintText: "Enter your street name 1",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: TextFormField(
                    onSaved: (strN2) => street2 = strN2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Street Name",
                      labelStyle: TextStyle(fontSize: 15.0),
                      hintText: "Enter your street name 2",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    onSaved: (cty) => city = cty,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "City",
                      labelStyle: TextStyle(fontSize: 15.0),
                      hintText: "Enter your city",
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: submit,
                  child: Container(
                    height: 50.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UserInfoDetails {
  UserInfoDetails(
      this.name, this.homeNumber, this.street1, this.street2, this.city);

  String name;
  String homeNumber;
  String street1;
  String street2;
  String city;
}
