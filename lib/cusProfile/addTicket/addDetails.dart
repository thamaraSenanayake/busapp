import 'package:flutter/material.dart';
import 'package:quickbussl/database/apiCall.dart';
import 'package:quickbussl/model/seat.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/module/getLocation.dart';

import '../../const.dart';


class AddDetails extends StatefulWidget {
  final User user;
  final Seat seat;
  final Trip trip;
  // final double tripDistance;
  // final double fullPrice;
  // final DateTime startTime;
  // final LatLng startPosition;
  AddDetails({Key key,@required this.seat,@required this.user,@required this.trip}) : super(key: key);

  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  Seat _seat;
  String _getInPlaceError = "";
  String _getOutPlaceError = "";
  String _title = "Add Details";
  double _width=0.0;

  _setArriveTime() async {
    if( _seat.getInLocation != null ){
      DistanceValues _values = await getDistance(_seat.getInLocation,widget.trip.startPosition);
      _seat.arriveTime =  widget.trip.startTime.add(_values.duration);
    }
  }

  _setEndTime() async {
    if( _seat.getInLocation != null && _seat.getOutLocation != null ){
      DistanceValues _values = await getDistance(_seat.getInLocation,_seat.getOutLocation); 

      if(_values.distance > widget.trip.totalDistance/2){
        setState(() {
          _seat.ticketPrice = widget.trip.totalPrice;
        });
      }else{
        setState(() {
          _seat.ticketPrice = widget.trip.totalPrice/2;
        });
      }
    }
    
  }

  _done(){
    bool _validation = true;
    if(_seat.getInPlace.isEmpty){
      setState(() {
        _getInPlaceError = "Required Field";
      });
      _validation = false;
    }
    if(_seat.getOutPlace.isEmpty){
      setState(() {
        _getOutPlaceError = "Required Field";
      });
      _validation = false;
    }
    if(_validation){
      _seat.email = widget.user.email;
      Navigator.pop(context,_seat);
    }
  }

  _initValues(){
   _seat = widget.seat;
  }

  @override
  void initState() {
    super.initState();
    _initValues();
  }


  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:Column(
            children: [
              Container(
                height: 40,
                width: _width,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context,_seat);
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            color:AppData.primaryColor,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        _title,
                        style: TextStyle(
                          color: AppData.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 5),
                child: Container(
                  width: _width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Get in location: ",
                        style: TextStyle(
                          color: AppData.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          backgroundColor: Colors.white
                        ),
                      ),
                      Text(
                        _getInPlaceError,
                        style: TextStyle(
                          color: AppData.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GetLocation(
                setLocation: (place,position){
                  setState(() {
                    _getInPlaceError = "";
                  });
                  _seat.getInLocation = position;
                  _seat.getInPlace = place;
                  _setEndTime();
                  _setArriveTime();
                }, initLocation: _seat.getInPlace,
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 5),
                child: Container(
                  width: _width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Get off location: ",
                        style: TextStyle(
                          color: AppData.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          backgroundColor: Colors.white
                        ),
                      ),
                      Text(
                        _getOutPlaceError,
                        style: TextStyle(
                          color: AppData.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GetLocation(
                setLocation: (place,position){
                  setState(() {
                    _getOutPlaceError = "";
                  });
                  _seat.getOutLocation = position;
                  _seat.getOutPlace = place;
                  _setEndTime();
                }, initLocation: _seat.getOutPlace,
              ),
              _seat.ticketPrice != null?Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                child: Container(
                  width:_width,
                  child: Text(
                    "Ticket price: Rs.${_seat.ticketPrice.toStringAsFixed(0)}/=",
                    style: TextStyle(
                      color: AppData.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.white
                    ),
                  ),
                ),
              ):Container(),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                text: "Done", 
                buttonClick: (){
                  _done();
                }, 
                shadow: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}