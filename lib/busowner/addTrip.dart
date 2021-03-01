import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickbussl/busowner/profileBase.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/module/customDatePicker.dart';
import 'package:quickbussl/module/customTimePicker.dart';
import 'package:quickbussl/module/textbox.dart';

import '../const.dart';

class AddTrip extends StatefulWidget {
  final User user;
  final BusOwnerProfileBaseListener listener;
  AddTrip({Key key,@required this.listener,@required this.user}) : super(key: key);

  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  var chars = "abcdefghijklmnopqrstuvwxyz0123456789";

  double _width = 0.0;
  Trip _trip = Trip();

  String _startTimeError = '';
  String _endTimeError = '';
  String _travelDateError = '';
  String _startLocationError = '';
  String _endLocationError = '';
  TextEditingController _timeEstimate = TextEditingController();

  

  _done() async {
    bool _validation = true;
    if(_trip.startLocation.isEmpty){
      setState(() {
        _startLocationError = "Required Field";
      });
      _validation = false;
    }
    if(_trip.endLocation.isEmpty){
      setState(() {
        _endLocationError = "Required Field";
      });
      _validation = false;
    }
    if(_validation){
      Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);

      _trip.id = new DateTime.now().millisecondsSinceEpoch.toString();

      for (var i = 0; i < 10; i++) {
        _trip.id += chars[rnd.nextInt(chars.length)];
      }

      await Database().addTrip(_trip);
      widget.listener.moveToPage(BusOwnerPages.OnGoing);

    }
  }

  _setEndTime(){
    
  }

  @override
  void initState() { 
    super.initState();
    _trip.startLocation = "";
    _trip.endLocation = "";
    _trip.startPosition = LatLng(6.9218374, 79.8211859);
    _trip.endPosition =  LatLng(6.9887912,81.0415076);
    _trip.highWayBus = false;
    _trip.busOwnerEmail = widget.user.email;
    _trip.startTime = DateTime.now();
    _trip.endTime =DateTime.now().add(Duration(hours: 5));
    _trip.travelDate = DateTime.now();
    _trip.busName = widget.user.name;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Container(
      // color: Colors.blue,
       child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 5),
              child: Container(
                width: _width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trip Start Location: ",
                      style: TextStyle(
                        color: AppData.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        backgroundColor: Colors.white
                      ),
                    ),
                    Text(
                      _startLocationError,
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
            TextBox(
              textBoxKey: null, 
              shadowDisplay: false,
              onChange: (val){

              }, 
              errorText: ""
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 5),
              child: Container(
                width: _width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trip End Location: ",
                      style: TextStyle(
                        color: AppData.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        backgroundColor: Colors.white
                      ),
                    ),
                    Text(
                      _endLocationError,
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
            TextBox(
              shadowDisplay: false,
              textBoxKey: null, 
              onChange: (val){

              }, 
              errorText: ""
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 5),
              child: Container(
                width: _width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trip Date: ",
                      style: TextStyle(
                        color: AppData.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        backgroundColor: Colors.white
                      ),
                    ),
                    Text(
                      _travelDateError,
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
            CustomDatePicker(
              initDate: DateTime.now(), 
              onChange: (val){
                _trip.travelDate = val;
              }, 
              title: "Date:"
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 5),
              child: Container(
                width: _width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trip Start Time: ",
                      style: TextStyle(
                        color: AppData.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        backgroundColor: Colors.white
                      ),
                    ),
                    Text(
                      _startTimeError,
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
            CustomTimePicker(
              initTime: TimeOfDay.now(), 
              onChange: (val){
                _trip.startTime =DateTime(_trip.travelDate.year,_trip.travelDate.month,_trip.travelDate.day, val.hour, val.minute);
                _setEndTime();
              }, 
              title: "Time"
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 0),
              child: Container(
                width: _width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Estimate Travel End Time : ",
                      style: TextStyle(
                        color: AppData.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        backgroundColor: Colors.white
                      ),
                    ),
                    Text(
                      "",
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
            TextBox(
              shadowDisplay: false,
              textBoxKey: null, 
              textEditingController: _timeEstimate,
              onChange: (val){

              }, 
              errorText: "",
              enable: false,
            ),

            CheckboxListTile(
              title: Padding(
                padding: const EdgeInsets.only(left:5.0),
                child: Text(
                  "Highway bus : ",
                  style: TextStyle(
                    color: AppData.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    backgroundColor: Colors.white
                  ),
                ),
              ),
              value: _trip.highWayBus, 
              activeColor:AppData.primaryColor,
              onChanged: (val){
                setState(() {
                  _trip.highWayBus = val;
                });
              }
            ),

            SizedBox(height:50),

            CustomButton(
              text: "Done", 
              shadow: false,
              buttonClick: (){
                _done();
              }
            )

           ],
         ),
       ),
    );
  }
}