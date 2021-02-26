import 'package:flutter/material.dart';
import 'package:quickbussl/busowner/profileBase.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';

class TripHistory extends StatefulWidget {
  final BusOwnerProfileBaseListener listener;
  final User user;
  TripHistory({Key key,@required this.listener,@required this.user}) : super(key: key);

  @override
  _TripHistoryState createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      //  child: child,
    );
  }
}