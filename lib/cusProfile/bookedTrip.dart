import 'package:flutter/material.dart';
import 'package:quickbussl/model/trip.dart';

class BookedTrip extends StatefulWidget {
  final Trip trip;
  BookedTrip({Key key, this.trip}) : super(key: key);

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