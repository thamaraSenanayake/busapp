import 'package:flutter/material.dart';
import 'package:quickbussl/busowner/profileBase.dart';
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
  double _width = 0.0;
  Trip _trip = Trip();

  String _startTimeError = '';
  String _endTimeError = '';
  String _travelDateError = '';
  String _startLocationError = '';
  String _endLocationError = '';

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
              }, 
              title: "Time"
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 5),
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
              onChange: (val){

              }, 
              errorText: "",
              enable: false,
            ),

            SizedBox(height:50),

            CustomButton(
              text: "Done", 
              shadow: false,
              buttonClick: (){

              }
            )

           ],
         ),
       ),
    );
  }
}