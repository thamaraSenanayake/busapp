import 'package:flutter/material.dart';
import 'package:quickbussl/cusProfile/profileBase.dart';
import 'package:quickbussl/model/trip.dart';

class BookedTrip extends StatefulWidget {
  final Trip trip;
  final ProfileBaseListener listener;
  BookedTrip({Key key,@required this.trip,@required this.listener}) : super(key: key);

  @override
  _BookedTripState createState() => _BookedTripState();
}

class _BookedTripState extends State<BookedTrip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      //  child: child,
    );
  }
}