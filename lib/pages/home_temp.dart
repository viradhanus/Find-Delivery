// import 'package:finddelivery/pages/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomeTemp extends StatefulWidget {
//   // HomeTemp({Key key}) : super(key: key);
//   static const String id = "home";

//   @override
//   _HomeTempState createState() => _HomeTempState();
// }

// class _HomeTempState extends State<HomeTemp> {

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(25.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[

//               RaisedButton(
//                 child: Text('Log out'),
//                 color: Colors.blueAccent,
//                 textColor: Colors.white,
//                 elevation: 7.0,
//                 onPressed: () => {
//                   FirebaseAuth.instance.signOut().then((onValue){
//                     Navigator.of(context).pushReplacementNamed(LoginPage.id);
//                   }).catchError((e){
//                     print(e);
//                   })
//                 },
//               ),         
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


