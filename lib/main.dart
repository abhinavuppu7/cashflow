import 'package:cashflow/screens/Firstscreen.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/ABHINAV/AndroidStudioProjects/cashflow/lib/screens/Homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool amountexists;
  @override
  //  void initState() {
  //    // TODO: implement initState
  //    super.initState();
  // getData();
  //  }
  //  getData() async{
  //    SharedPreferences prefs= await SharedPreferences.getInstance();
  // setState(() {
  //   amountexists=prefs.containsKey('cashbalance');
  // });

  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Homescreen(),
    );
  }
}

//
// class MyApp extends StatefulWidget {
//   // This widget is the root of your application.
//   @override
//
//
//   Widget build(BuildContext context) {
//     return MaterialApp(
//      debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//
//       home: Homescreen(),
//     );
//   }
// }
