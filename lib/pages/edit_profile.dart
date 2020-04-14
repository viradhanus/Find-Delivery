import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finddelivery/widgets/progress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:finddelivery/models/user.dart';
import 'package:finddelivery/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';


// final FacebookLogin facebookSignIn = new FacebookLogin();
// final GoogleSignIn googleSignIn = GoogleSignIn();

class EditProfile extends StatefulWidget {
  final String currentUserId;

  EditProfile({this.currentUserId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController dispNameController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController streetName1Controller = TextEditingController();
  TextEditingController streetName2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  bool isLoading = false;
  User user;
  bool _dispNameValid = true;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await userRef.document(widget.currentUserId).get();
    user = User.fromDocument(doc);
    dispNameController.text = user.name;
    homeNumberController.text = user.homeNumber;
    streetName1Controller.text = user.street1;
    streetName2Controller.text = user.street2;
    cityController.text = user.city;

    setState(() {
      isLoading = false;
    });
  }

  Column buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Name",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: dispNameController,
          decoration: InputDecoration(
            hintText: "Update Your Name",
            errorText: _dispNameValid ? null : "Enter a valid name",
          ),
        )
      ],
    );
  }

  Column buildHNumField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Home Number",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: homeNumberController,
          decoration: InputDecoration(
            hintText: "Update Home Number",
          ),
        )
      ],
    );
  }

  Column buildStr1Field() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Street Name 1",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: streetName1Controller,
          decoration: InputDecoration(
            hintText: "Update Street Name 1",
          ),
        )
      ],
    );
  }
    Column buildStr2Field() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Street Name 2",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: streetName2Controller,
          decoration: InputDecoration(
            hintText: "Update Street Name 2",
          ),
        )
      ],
    );
  }

    Column buildCityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "City",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: cityController,
          decoration: InputDecoration(
            hintText: "Update City",
          ),
        )
      ],
    );
  }

  updateProfileData() {
    setState(() {
      dispNameController.text.trim().length < 3 ||
              dispNameController.text.isEmpty
          ? _dispNameValid = false
          : _dispNameValid = true;

    });

    if (_dispNameValid) {
      userRef.document(widget.currentUserId).updateData({
        "name": dispNameController.text,
        "homeNumber": homeNumberController.text,
        "street1": streetName1Controller.text,
        "street2": streetName2Controller.text,
        "city": cityController.text,
      });
      SnackBar snackBar = SnackBar(content: Text("Profile Updated!"));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  Future<void> _signOut() async {
    await facebookSignIn.logOut();

    await googleSignIn.signOut();
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loggedUserId');

    Navigator.push(context, MaterialPageRoute(builder: (context)=> Home() ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.done,
              size: 30.0,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: isLoading
          ? circularProgress()
          : ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            buildNameField(),
                            buildHNumField(),
                            buildStr1Field(),
                            buildStr2Field(),
                            buildCityField(),
                          ],
                        ),
                      ),
                      RaisedButton(
                        onPressed: updateProfileData,
                        child: Text(
                          "Update Profile",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: FlatButton.icon(
                          onPressed: _signOut,
                          icon: Icon(Icons.cancel, color: Colors.red),
                          label: Text(
                            "Logout",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
