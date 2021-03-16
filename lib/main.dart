import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickbussl/login/loginbase.dart';

void main() {
  // Workmanager.initialize(callbackDispatcher);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginBase(),
    );
  }
}

