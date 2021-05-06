import 'package:flutter/material.dart';
import 'file:///C:/Users/ABHINAV/AndroidStudioProjects/cashflow/lib/screens/Homescreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
