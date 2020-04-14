import 'package:finddelivery/models/user.dart';
import 'package:finddelivery/pages/edit_profile.dart';
import 'package:finddelivery/widgets/header.dart';
import 'package:finddelivery/widgets/progress.dart';
import 'package:finddelivery/widgets/rounded_btn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class Profile extends StatefulWidget {
  final String userID;
  Profile({this.userID});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool homeNumber = false;
  bool street1 = false;
  bool street2 = false;
  bool city = false;

  buildProfile() {
    return FutureBuilder(
      future: userRef.document(widget.userID).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        User user = User.fromDocument(snapshot.data);
        // setState(() {
        if (user.homeNumber.isNotEmpty) homeNumber = true;
        if (user.street1.isNotEmpty) street1 = true;
        if (user.street2.isNotEmpty) street2 = true;
        if (user.city.isNotEmpty) city = true;
        // });

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
              homeNumber
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                      child: Text(user.homeNumber,
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                      child: Text("--------",
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                    ),
              street1
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                      child: Text(user.street1,
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                      child: Text("--------",
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                    ),
              street2
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                      child: Text(user.street2,
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                      child: Text("--------",
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                    ),
              city
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                      child: Text(user.city,
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                      child: Text("--------",
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

  editProfile() {
     Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(currentUserId: widget.userID)));
  }

  Future<void> _signOut() async {
    await facebookSignIn.logOut();

    await googleSignIn.signOut();
    // await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loggedUserId');

    Navigator.push(context, MaterialPageRoute(builder: (context)=> Home() ));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                    child: RoundedButton(
                      title: 'Logout',
                      minWidth: 75.0,
                      height: 25.0,
                      color: Colors.redAccent,
                      onPressed:_signOut,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                    child: RoundedButton(
                      title: 'Edit',
                      minWidth: 75.0,
                      height: 25.0,
                      color: Colors.blueAccent,
                      onPressed: editProfile,
                    ),
                  ),
                ],
              ),
             
            ],
          ),
        ],
      ),
    );
  }
}
