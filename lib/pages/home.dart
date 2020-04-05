import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    // Detects when user signed in
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });
    // Reauthenticate user when app is opened
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error signing in: $err');
    });
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      print('User signed in!: $account');
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  Widget buildAuthScreen() {
    return RaisedButton(
      child: Text('Logout'),
      onPressed: logout,
    );
  }

  Widget buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        color: Colors.white,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //       begin: Alignment.topRight,
        //       end: Alignment.bottomLeft,
        //       colors: [
        //         Theme.of(context).accentColor,
        //         Theme.of(context).primaryColor,
        //       ]),
        // ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Find Delivery',
              style: TextStyle(
                fontFamily: 'Signatra',
                fontSize: 70.0,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 250.0,
              height: 250.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/delivery_cab.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                width: 180.0,
                height: 40.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/google_signin_button.png'),
                      fit: BoxFit.cover),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
