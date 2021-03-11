import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/module/customDatePicker.dart';
import 'package:quickbussl/module/customDropDown.dart';

import '../../const.dart';
class SelectLocation extends StatefulWidget {
  //final Trip trip;
  final Function(String,String,DateTime) nextPage;
  final String selectedDeparture;
  final String selectedArrive;
  final DateTime selectedDate;
  SelectLocation({Key key,@required this.nextPage,@required this.selectedDeparture,@required this.selectedArrive,@required this.selectedDate}) : super(key: key);

  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {

  List<String> _departure = [];
  List<String> _arrive = [];
  List<Trip> _tripList = [];
  double _width = 0.0;
  String _departureError = '';
  String _arriveError = '';
  String _dateError = '';
  String _selectedDeparture = '';
  String _selectedArrive = '';
  DateTime _selectedDate;
  bool _loading = true;

  _search(){
    // _tripList = await Database().searchTrip(startLocation, endLocation, date)
    widget.nextPage(_selectedDeparture,_selectedArrive,_selectedDate);
  }

  _initValue() async {
    _departure = _arrive = await Database().getLocationList();

    if(_departure.length != 0){
      if(widget.selectedDeparture != null && widget.selectedDeparture.isNotEmpty){
        _selectedDeparture = widget.selectedDeparture;
      }else{
        _selectedDeparture = _departure[0];
      }
  
      if(widget.selectedArrive != null && widget.selectedArrive.isNotEmpty){
        _selectedArrive = widget.selectedArrive;
      }else{
        _selectedArrive = _arrive[0];
      }
    }

    if(widget.selectedDate != null){
      _selectedDate = widget.selectedDate;
    }else{
      _selectedDate = DateTime.now();
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
    _initValue();
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
      ):
      Column(
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
              _selectedDeparture = val;
            }, 
            selectedText: _selectedDeparture
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
              _selectedArrive = val;
            }, 
            selectedText: _selectedArrive
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
            initDate: _selectedDate, 
            onChange: (val){
              _selectedDate = val;
            }, 
            title: "Date"
          ),
          SizedBox(height:50),
          CustomButton(text: "Search", buttonClick:(){_search();},shadow: false,)
      ],
    );
  }
}