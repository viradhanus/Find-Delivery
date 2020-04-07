// import 'package:finddelivery/pages/home_temp.dart';
// import 'package:finddelivery/pages/signup.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class LoginPage extends StatefulWidget {
//   // LoginPage({Key key}) : super(key: key);
//   static const String id = "login";

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   String _email;
//   String _password;

//   GoogleSignIn googleAuth = GoogleSignIn();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(25.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Email',
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _email = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 15.0),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Password',
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _password = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 20.0),
//               RaisedButton(
//                 child: Text('Login'),
//                 color: Colors.blueAccent,
//                 textColor: Colors.white,
//                 elevation: 7.0,
//                 onPressed: () => {
//                   FirebaseAuth.instance
//                       .signInWithEmailAndPassword(
//                           email: _email, password: _password)
//                       .then((user) {
//                     Navigator.of(context).pushReplacementNamed(HomeTemp.id);
//                   }).catchError((e) {
//                     print(e);
//                   })
//                 },
//               ),
//               SizedBox(height: 20.0),
//               RaisedButton(
//                 child: Text('Google SignIn'),
//                 color: Colors.blueAccent,
//                 textColor: Colors.white,
//                 elevation: 7.0,
//                 onPressed: () => {
//                   googleAuth.signIn().then((result){
//                     result.authentication.then((googleKey){
//                       FirebaseAuth.instance.signInwithG

//                     }).catchError((onError){
//                       print(onError);
//                     });
//                   }).catchError((onError){
//                       print(onError);
//                     }),

//                 },
//               ),
//               SizedBox(height: 15.0),
//               Text('Don\'t have an account?'),
//               SizedBox(height: 15.0),
//               RaisedButton(
//                 child: Text('Sign Up'),
//                 color: Colors.blueAccent,
//                 textColor: Colors.white,
//                 elevation: 7.0,
//                 onPressed: () => {Navigator.of(context).pushNamed(SignUp.id)},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
