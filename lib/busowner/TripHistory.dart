import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickbussl/busowner/profileBase.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/busTripDisplay.dart';
import 'package:quickbussl/module/emptyView.dart';

import '../const.dart';

class TripHistory extends StatefulWidget {
  final BusOwnerProfileBaseListener listener;
  final User user;
  TripHistory({Key key,@required this.listener,@required this.user}) : super(key: key);

  @override
  _TripHistoryState createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> implements BusTripDisplayListener {
  List<Trip> _tripList = [];
  List<Widget> _widgetList = [];
  bool _loading = true;


  @override
  void initState() { 
    super.initState();
    _tripsToGo();
  }
  
  _tripsToGo() async {
    _tripList = await Database().pastTripBusOwner(widget.user.email);
    for (var item in _tripList) {
      _widgetList.add(
        BusTripDisplay(busTrip: item, listener: this, userType: null,)
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
        ):
        _widgetList.length ==0?
        EmptyView(msg: "Did go a bus trip yet"):
        Expanded(
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
    // TODO: implement busTripClick
    // throw UnimplementedError();
  }

  @override
  locationGetOrSet(Trip busTrip) {
    // TODO: implement locationGetOrSet
    throw UnimplementedError();
  }
}