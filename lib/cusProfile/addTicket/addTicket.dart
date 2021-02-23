import 'package:flutter/material.dart';
import 'package:quickbussl/cusProfile/addTicket/selectBus.dart';
import 'package:quickbussl/cusProfile/addTicket/selectLocation.dart';
import 'package:quickbussl/cusProfile/addTicket/selectSeat.dart';
import 'package:quickbussl/cusProfile/profileBase.dart';
import 'package:quickbussl/model/trip.dart';

import '../../const.dart';


class AddTicketBase extends StatefulWidget {
  final Trip trip;
  // final Function search;
  AddTicketBase({Key key,@required this.trip}) : super(key: key);

  @override
  _AddTicketStateBase createState() => _AddTicketStateBase();
}

class _AddTicketStateBase extends State<AddTicketBase> {
  
  String _title = "Enter Location";
  double _width=0.0;
  CusProfilePages _profilePage = CusProfilePages.SelectLocation;

  _initValues(){
    
  }

  @override
  void initState() {
    super.initState();
    _initValues();
  }

  _back(){
    if(_profilePage == CusProfilePages.SelectBus){
      setState(() {
        _title = "Enter Location";
        _profilePage = CusProfilePages.SelectLocation;
      });
    }
    if(_profilePage == CusProfilePages.SelectSeat){
      setState(() {
        _title = "Enter Location";
        _profilePage = CusProfilePages.SelectBus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Container(
      child:Column(
        children: [
          Container(
            height: 40,
            width: _width,
            // decoration: BoxDecoration(
            //   color: AppData.primaryColor,
            // ),
            child: Stack(
              children: [
                _profilePage == CusProfilePages.SelectLocation?GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Center(
                      child: Icon(
                        Icons.menu,
                        color:AppData.primaryColor,
                      ),
                    ),
                  ),
                ):GestureDetector(
                  onTap: (){
                    _back();
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color:AppData.primaryColor,
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
          Container(
            child: _profilePage==CusProfilePages.SelectLocation?
            SelectLocation(
              trip: widget.trip, 
              nextPage: (){
                setState(() {
                  _title = "Select Bus";
                  _profilePage=CusProfilePages.SelectBus;
                });
              }
            ):_profilePage==CusProfilePages.SelectBus?
            SelectBus(
              trip: widget.trip, 
              nextPage: (Trip trip){
                setState(() {
                  _title = "Select Seat";
                  _profilePage=CusProfilePages.SelectSeat;
                });
              }
            ):_profilePage==CusProfilePages.SelectSeat?
            SelectSeat(
              trip: widget.trip, 
              nextPage: (int seatNum){
                setState(() {
                  _title = "Select Seat";
                  _profilePage=CusProfilePages.SelectSeat;
                });
              }
            ):
            Container(),
          ),
        ],
      ),
    );
  }
}