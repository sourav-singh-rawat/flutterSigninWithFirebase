import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'SignInPage.dart';
import 'SignUpPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HomePage App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: <String,WidgetBuilder>{
        "/SignInPage": (BuildContext context) => SignInPage(),
        "/SignUpPage" : (BuildContext context) => SignUpPage(),
      },
    );
  }
}