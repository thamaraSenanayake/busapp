import 'package:flutter/material.dart';
import 'package:quickbussl/const.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/module/busTripDisplay.dart';

class SelectBus extends StatefulWidget {
  final Trip trip;
  final Function(Trip) nextPage;
  SelectBus({Key key,@required this.trip,@required this.nextPage}) : super(key: key);

  @override
  _SelectBusState createState() => _SelectBusState();
}

class _SelectBusState extends State<SelectBus> implements BusTripDisplayListener {
  double _width = 0.0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Column(
      children: [
        BusTripDisplay(busTrip: null, listener: this)
        
        
      ],
    );
  }

  @override
  busTripClick(Trip busTrip) {
    widget.nextPage(busTrip);
  }
}