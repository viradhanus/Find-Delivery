// import 'package:finddelivery/pages/login.dart';
// import 'package:finddelivery/services/userManagement.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class SignUp extends StatefulWidget {
//   // SignUp({Key key}) : super(key: key);
//   static const String id = "signup";

//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   String _email;
//   String _password;


//    @override
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
//                 child: Text('Sign Up'),
//                 color: Colors.blueAccent,
//                 textColor: Colors.white,
//                 elevation: 7.0,
//                 onPressed: () => {

//                   FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)
//                   .then((signedInUser){
//                     UserManagement().storeNewUser(signedInUser.user,context);
//                   })
//                   .catchError((e){
//                     print(e);
//                   })

//                 },
//               ),
//               SizedBox(height: 15.0),
//               Text('Got an account?'),
//               SizedBox(height: 15.0),
//               RaisedButton(
//                 child: Text('Log In'),
//                 color: Colors.blueAccent,
//                 textColor: Colors.white,
//                 elevation: 7.0,
//                 onPressed: () => {
//                   Navigator.of(context).pushNamed(LoginPage.id)

//                 },
//               ),              
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
