import 'package:flutter/material.dart';
import 'package:quickbussl/model/trip.dart';

class BookedHistory extends StatefulWidget {
  final Trip trip;
  BookedHistory({Key key, this.trip}) : super(key: key);

  @override
  _BookedHistoryState createState() => _BookedHistoryState();
}

class _BookedHistoryState extends State<BookedHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      //  child: child,
    );
  }
}