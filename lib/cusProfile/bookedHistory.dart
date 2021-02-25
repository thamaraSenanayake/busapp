import 'package:flutter/material.dart';
import 'package:quickbussl/cusProfile/profileBase.dart';
import 'package:quickbussl/model/trip.dart';

class BookedHistory extends StatefulWidget {
  final Trip trip;
  final ProfileBaseListener listener;
  BookedHistory({Key key, this.trip,@required this.listener}) : super(key: key);

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