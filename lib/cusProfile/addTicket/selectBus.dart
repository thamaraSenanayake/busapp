import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/busTripDisplay.dart';
import 'package:quickbussl/module/emptyView.dart';

import '../../const.dart';

class SelectBus extends StatefulWidget {
  final String selectedDeparture;
  final String selectedArrive;
  final DateTime selectedDate;  
  final Function(Trip) nextPage;
  SelectBus({Key key,@required this.nextPage,@required this.selectedDeparture,@required this.selectedArrive,@required this.selectedDate}) : super(key: key);

  @override
  _SelectBusState createState() => _SelectBusState();
}

class _SelectBusState extends State<SelectBus> implements BusTripDisplayListener {
  double _width = 0.0;
  bool _loading = true;
  List<Trip> _tripList = [];
  List<Widget> _tripWidgetList = [];

  _getBus() async {
    _tripList = await Database().searchTrip(widget.selectedDeparture, widget.selectedArrive, widget.selectedDate);
    for (var item in _tripList) {
      _tripWidgetList.add(
        BusTripDisplay(busTrip: item, listener: this,userType: UserType.Passenger,)
      );
    }
    if(mounted){
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() { 
    super.initState();
    _getBus();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return _loading? Expanded(
        child: Container(
          color: Color.fromRGBO(128, 128, 128, 0.3),
          child: SpinKitDoubleBounce(
            color: AppData.primaryColor2,
            size: 50.0,
          ),
        ),
      ):_tripWidgetList.length == 0?EmptyView(msg: "Not added any bus trips to your selected date, add a new date and try "):Column(
      children: _tripWidgetList,
    );
  }

  @override
  busTripClick(Trip busTrip) {
    widget.nextPage(busTrip);
  }

  @override
  locationGetOrSet(Trip busTrip) {
    // TODO: implement locationGetOrSet
    throw UnimplementedError();
  }
}