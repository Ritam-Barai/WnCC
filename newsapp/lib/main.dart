import 'package:flutter/material.dart';
import 'package:newsapp/view/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home:  Home(),
    );
  }
}

