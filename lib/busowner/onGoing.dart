import 'package:flutter/material.dart';
import 'package:quickbussl/busowner/profileBase.dart';
import 'package:quickbussl/cusProfile/profileBase.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';

class OnGoing extends StatefulWidget {
  final User user;
  final BusOwnerProfileBaseListener listener;
  OnGoing({Key key,@required this.listener,@required this.user}) : super(key: key);

  @override
  _OnGoingState createState() => _OnGoingState();
}

class _OnGoingState extends State<OnGoing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      //  child: child,
    );
  }
}