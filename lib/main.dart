// import 'package:finddelivery/pages/home_temp.dart';
// import 'package:finddelivery/pages/login.dart';
// import 'package:finddelivery/pages/signup.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Find Delivery',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Colors.purple,
//         accentColor: Colors.pink,
//       ),

//       initialRoute: LoginPage.id,
//       routes: {
//         LoginPage.id:(context) => LoginPage(),
//         HomeTemp.id:(context) => HomeTemp(),
//         SignUp.id:(context) => SignUp(),
//       },
//     );
//   }
// }

import 'package:finddelivery/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.pink,
      ),
      home: Home(),
    );
  }
}