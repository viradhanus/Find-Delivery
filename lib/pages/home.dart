import 'dart:developer';
import 'package:finddelivery/pages/timeline.dart';
import 'package:finddelivery/pages/profile.dart';
import 'package:finddelivery/pages/search.dart';
import 'package:finddelivery/pages/upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// import 'package:finddelivery/pages/userProfileInfo.dart';
import 'activity_feed.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showSpinner = false;
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  FirebaseAuth _auth;
  FirebaseUser mCurrentUser;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    _auth = FirebaseAuth.instance;
    _getCurrentUser();
    print('here outside async');

    // Detects when user signed in
    // googleSignIn.onCurrentUserChanged.listen((account) {
    //   addFirebaseAuth(account);
    //   handleSignIn(account);
    // }, onError: (err) {
    //   showToast('Signing In Failed');
    //   print('Error signing in: $err');
    // });
    // Reauthenticate user when app is opened
    // googleSignIn.signInSilently(suppressErrors: false).then((account) {
    //   handleSignIn(account);
    // }).catchError((err) {
    //   print('silently: $err');
    // });
  }

  _getCurrentUser() async {
    mCurrentUser = await _auth.currentUser(); //user in the cache
    setState(() {
      mCurrentUser != null ? isAuth = true : isAuth = false;
    });
  }

  // addFirebaseAuth(GoogleSignInAccount googleUser) async {
  //   if (googleUser != null) {
  //     GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.getCredential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     final FirebaseUser user =
  //         (await _auth.signInWithCredential(credential)).user;
  //     showToast("Hi, " + user.displayName);
  //   }
  // }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
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

//google stuff
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    handleSignIn(googleSignInAccount);
  }

  handleSignIn(GoogleSignInAccount googleSignInAccount) async {
    if (googleSignInAccount != null) {
      print('User signed in!: $googleSignInAccount');

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;
      showToast("Hi, " + user.displayName);

      // return 'signInWithGoogle succeeded: $user';

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

//facebook stuff
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  Future _signIn(BuildContext context) async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);

        FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
        showToast("Hi, " + user.displayName);

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
          isAuth = true; //showLoggedInUI
        });

        break;
      case FacebookLoginStatus.cancelledByUser:
        // showCancelledMessage
        showToast('Signing In Cancelled');
        setState(() {
          isAuth = false;
        });
        break;
      case FacebookLoginStatus.error:
        // showErrorOnUI
        showToast('Signing In Failed');
        setState(() {
          isAuth = false;
        });
        break;
    }
  }

  Future<void> _signOut() async {
    await facebookSignIn.logOut();

    await googleSignIn.signOut();
    await _auth.signOut();
    setState(() {
      isAuth = false;
    });

    print("User Sign Out");
  }

  Widget buildAuthScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: _signOut),
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
          // color: Colors.blueAccent,
          inAsyncCall: showSpinner,
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            padding: EdgeInsetsDirectional.only(top:10.0,bottom: 5.0),
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
                GoogleSignInButton(
                  onPressed: () {
                    setState(() {
                      showSpinner = true;
                    });
                    // login();
                    signInWithGoogle();
                  },
                  darkMode: true, // default: false
                ),
                SizedBox(
                  height: 25,
                ),
                FacebookSignInButton(onPressed: () {
                  _signIn(context)
                      // .then((FirebaseUser user) => print(user))
                      .catchError((e) {
                    if (e.code ==
                        "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL") {
                      showToast("Please Sign In With Google");
                    }
                  });
                }),
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

  /// The provider???s user ID for the user.
  final String uid;

  /// The name of the user.
  final String displayName;

  /// The URL of the user???s profile photo.
  final String photoUrl;

  /// The user???s email address.
  final String email;
}
