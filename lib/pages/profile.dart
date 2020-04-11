import 'package:finddelivery/models/user.dart';
import 'package:finddelivery/widgets/header.dart';
import 'package:finddelivery/widgets/progress.dart';
import 'package:finddelivery/widgets/rounded_btn.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Profile extends StatefulWidget {
  final String userID;
  Profile({this.userID});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  buildProfile() {
    return FutureBuilder(
      future: userRef.document(widget.userID).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        User user = User.fromDocument(snapshot.data);
        return Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                child: Text(
                  "Name :",
                  style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                child: Text(user.name,
                    style: TextStyle(
                      fontSize: 18.0,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                child: Text(
                  "Delivery Address :",
                  style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                child: Text(user.homeNumber,
                    style: TextStyle(
                      fontSize: 18.0,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                child: Text(user.street1,
                    style: TextStyle(
                      fontSize: 18.0,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                child: Text(user.street2,
                    style: TextStyle(
                      fontSize: 18.0,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                child: Text(user.city,
                    style: TextStyle(
                      fontSize: 18.0,
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header(context, titleText: "Profile"),
      body: ListView(
        children: <Widget>[
           Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  width: 250.0,
                  height: 250.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/delivery_cab.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                buildProfile(),
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                  child: RoundedButton(
                    title: 'Edit',
                    minWidth: 150.0,
                    height: 25.0,
                    color: Colors.blueAccent,
                    onPressed: () {
                      // edit;
                    },
                  ),
                ),
              ],
            ),
       
        ],
      ),
    );
  }
}
