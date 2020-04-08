import 'dart:developer';
import 'package:finddelivery/pages/timeline.dart';
import 'package:finddelivery/pages/profile.dart';
import 'package:finddelivery/pages/search.dart';
import 'package:finddelivery/pages/upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// import 'package:finddelivery/pages/userProfileInfo.dart';
import 'activity_feed.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showSpinner = false;
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    // FirebaseAuth.instance.currentUser().then((firebaseUser) {
    //   if (firebaseUser == null) {
    //     //signed out
    //     setState(() {
    //       isAuth = false;
    //     });
    //   } else {
    //     //signed in
    //     setState(() {
    //       isAuth = true;
    //     });
    //   }
    // });

    // Detects when user signed in
    googleSignIn.onCurrentUserChanged.listen((account) {
      addFirebaseAuth(account);
      handleSignIn(account);
    }, onError: (err) {
      showToast('Signing In Failed');
      print('Error signing in: $err');
    });
    // Reauthenticate user when app is opened
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('silently: $err');
    });
  }

  addFirebaseAuth(GoogleSignInAccount googleUser) async {
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      showToast("Hi, " + user.displayName);
    }
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      print('User signed in!: $account');

      setState(() {
        showSpinner = false;
        isAuth = true;
      });
    } else {
      setState(() {
        showSpinner = false;
        isAuth = false;
      });
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.jumpToPage(
      pageIndex,
    );
  }

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        // toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.blue,
        textColor: Colors.white);
  }

//facebook stuff
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  Future _signIn(BuildContext context) async {
    setState(() {
      showSpinner = true;
    });

    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);

        FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

        // UserInfoDetails userInfoDetails = new UserInfoDetails(
        //   user.uid,
        //   user.displayName,
        //   user.photoUrl,
        //   user.email,
        // );
        // Navigator.push(
        //   context,
        //   new MaterialPageRoute(
        //     builder: (context) => new UserProfileInfo(detailsUser: userInfoDetails),
        //   ),
        // );
        setState(() {
          showSpinner = false;
          isAuth = true;
        });
        // return user;
        // _showLoggedInUI();

        break;
      case FacebookLoginStatus.cancelledByUser:
        // _showCancelledMessage();
        showToast('Signing In Cancelled');
        setState(() {
          showSpinner = false;
          isAuth = false;
        });
        break;
      case FacebookLoginStatus.error:
        // _showErrorOnUI(result.errorMessage);
        showToast('Signing In Failed');
        setState(() {
          showSpinner = false;
          isAuth = false;
        });
        break;
    }
  }

  Future<Null> _signOut(BuildContext context) async {
    await facebookSignIn.logOut();
    setState(() {
      isAuth = false;
    });

    print('Signed out');
  }

  Widget buildAuthScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              _signOut(context);
              logout();
            }),
        title: Text("Sample"),
        centerTitle: true,
      ),
      body: PageView(
        children: <Widget>[
          Timeline(),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onTap,
          activeColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.whatshot),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.photo_camera,
                size: 35.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
            ),
          ]),
    );
  }

  Widget buildUnAuthScreen() {
    return Scaffold(
      body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            color: Colors.white,
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
                  onTap: () {
                    setState(() {
                      showSpinner = true;
                    });
                    login();
                  },
                  child: Container(
                    width: 180.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/google_signin_button.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                MaterialButton(
                  minWidth: 150.0,
                  onPressed: () => _signIn(context)
                      // .then((FirebaseUser user) => print(user))
                      .catchError((e) => print(e)),
                  child: new Text('Sign in with Facebook'),
                  color: Colors.lightBlueAccent,
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}

class UserInfoDetails {
  UserInfoDetails(this.uid, this.displayName, this.photoUrl, this.email);

  /// The provider’s user ID for the user.
  final String uid;

  /// The name of the user.
  final String displayName;

  /// The URL of the user’s profile photo.
  final String photoUrl;

  /// The user’s email address.
  final String email;
}
