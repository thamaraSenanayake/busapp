import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickbussl/busowner/displayPasengers.dart';
import 'package:quickbussl/busowner/profileBase.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/busTripDisplay.dart';
import 'package:quickbussl/module/topBar.dart';

import '../const.dart';

class OnGoing extends StatefulWidget {
  final User user;
  final BusOwnerProfileBaseListener listener;
  OnGoing({Key key,@required this.listener,@required this.user}) : super(key: key);

  @override
  _OnGoingState createState() => _OnGoingState();
}

class _OnGoingState extends State<OnGoing> implements BusTripDisplayListener{
  List<Trip> _tripList = [];
  List<Widget> _widgetList = [];
  bool _loading = true;


  @override
  void initState() { 
    super.initState();
    _tripsToGo();
  }
  
  _tripsToGo() async {
    _tripList = await Database().onGoingTripBusOwner(widget.user.email);
    for (var item in _tripList) {
      _widgetList.add(
        BusTripDisplay(busTrip: item, listener: this)
      );
    }
    _loading = false;
    if(mounted){
      setState(() {

      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        _loading? Expanded(
          child: Container(
            color: Color.fromRGBO(128, 128, 128, 0.3),
            child: SpinKitDoubleBounce(
              color: AppData.primaryColor2,
              size: 50.0,
            ),
          ),
        ):Expanded(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: _widgetList,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  busTripClick(Trip busTrip) {
    Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, _, __) => DisplayPassengers(
            trip: busTrip,
          ),
          opaque: false
        ),
      );
  }
}