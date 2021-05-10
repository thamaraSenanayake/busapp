import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickbussl/cusProfile/busLiveLocation.dart';
import 'package:quickbussl/cusProfile/profileBase.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/busTripDisplay.dart';
import 'package:quickbussl/module/topBar.dart';

import '../const.dart';

class BookedTrip extends StatefulWidget {
  final Trip trip;
  final User user;
  final ProfileBaseListener listener;
  BookedTrip({Key key,@required this.trip,@required this.listener,@required this.user}) : super(key: key);

  @override
  _BookedTripState createState() => _BookedTripState();
}

class _BookedTripState extends State<BookedTrip> implements BusTripDisplayListener{
  List<Trip> _tripList = [];
  List<Widget> _widgetList = [];
  bool _loading = true;


  @override
  void initState() { 
    super.initState();
    _getBookedTrip();
  }
  
  _getBookedTrip() async {
    _tripList = await Database().bookedTripCustomer(widget.user.email);
    for (var item in _tripList) {
      _widgetList.add(
        BusTripDisplay(busTrip: item, listener: this,userType: widget.user.userType,)
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
        TopBarModule(
          title: "Booked Trip", 
          buttonClick: (){
            widget.listener.openDrawer();
          }, 
          iconData: Icons.menu
        ),
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
        pageBuilder: (context, _, __) => BusLocation(
          trip: busTrip,
        ),
        opaque: false
      ),
    );
  }

  @override
  locationGetOrSet(Trip busTrip) {
    // TODO: implement locationGetOrSet
    // throw UnimplementedError();
  }
}