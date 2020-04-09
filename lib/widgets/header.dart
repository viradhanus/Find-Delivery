import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String titleText}) {
  return AppBar(
    title: Text(
      isAppTitle ? "Find Delivery" : titleText,
      style: TextStyle(
        color: Colors.white,
        // fontFamily: isAppTitle ? "Signatra" : "",
        // fontSize: isAppTitle ? 30.0 : 22.0,
        fontFamily:"Signatra",
        fontSize: 30.0,
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
