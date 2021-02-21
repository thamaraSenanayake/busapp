import 'package:flutter/material.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/module/customDatePicker.dart';
import 'package:quickbussl/module/customDropDown.dart';

import '../const.dart';

class AddLocation extends StatefulWidget {
  final Trip trip;
  AddLocation({Key key,@required this.trip}) : super(key: key);

  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  List<String> _departure = ['one','two','three','four','five'];
  List<String> _arrive = ['one','two','three','four','five'];
  double _width = 0.0;
  String _departureError = '';
  String _arriveError = '';
  String _dateError = '';

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Container(
      child:Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:10.0,bottom: 5),
            child: Container(
              width: _width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Departure: ",
                    style: TextStyle(
                      color: AppData.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.white
                    ),
                  ),
                  Text(
                    _departureError,
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
          CustomDropDown(
            list: _departure, 
            onChange: (val){
              print(val);
            }, 
            selectedText: _departure[0]
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top:10.0,bottom: 5),
            child: Container(
              width: _width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Arrive: ",
                    style: TextStyle(
                      color: AppData.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.white
                    ),
                  ),
                  Text(
                    _arriveError,
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
          CustomDropDown(
            list: _arrive, 
            onChange: (val){
              print(val);
            }, 
            selectedText: _arrive[0]
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top:10.0,bottom: 5),
            child: Container(
              width: _width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date: ",
                    style: TextStyle(
                      color: AppData.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.white
                    ),
                  ),
                  Text(
                    _dateError,
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
              // widget.trip.startDate = val;
            }, 
            title: "Date"
          ),
          SizedBox(height:50),
          CustomButton(text: "Search", buttonClick: (){},shadow: false,)
        ],
      ),
    );
  }
}