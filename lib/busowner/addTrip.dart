import 'package:flutter/material.dart';
import 'package:quickbussl/busowner/profileBase.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';

class AddTrip extends StatefulWidget {
  final User user;
  final BusOwnerProfileBaseListener listener;
  AddTrip({Key key,@required this.listener,@required this.user}) : super(key: key);

  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      //  child: child,
    );
  }
}