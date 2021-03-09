import 'package:flutter/material.dart';
import 'package:quickbussl/cusProfile/addTicket/selectBus.dart';
import 'package:quickbussl/cusProfile/addTicket/selectLocation.dart';
import 'package:quickbussl/cusProfile/addTicket/selectSeat.dart';
import 'package:quickbussl/cusProfile/addTicket/summery.dart';
import 'package:quickbussl/cusProfile/profileBase.dart';
import 'package:quickbussl/model/seat.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';

import '../../const.dart';


class AddTicketBase extends StatefulWidget {
  final User user;
  final Trip trip;
  final String selectedArrive;
  final String selectedDeparture;
  final DateTime selectedDate;
  final ProfileBaseListener listener;
  AddTicketBase({Key key,@required this.trip,@required this.user,@required this.listener,@required this.selectedArrive,@required this.selectedDeparture,@required this.selectedDate}) : super(key: key);

  @override
  _AddTicketStateBase createState() => _AddTicketStateBase();
}

class _AddTicketStateBase extends State<AddTicketBase> {
  Trip _trip;
  String _selectedArrive;
  String _selectedDeparture;
  DateTime _selectedDate;
  String _title = "Enter Location";
  double _width=0.0;
  CusProfilePages _profilePage = CusProfilePages.SelectLocation;

  _initValues(){
    _trip = widget.trip;
    _selectedArrive = widget.selectedArrive;
    _selectedDeparture = widget.selectedDeparture;
    _selectedDate = widget.selectedDate;
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
    if(_profilePage == CusProfilePages.PayForSeat){
      setState(() {
        _title = "Enter Location";
        _profilePage = CusProfilePages.SelectSeat;
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
                    widget.listener.openDrawer();
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Center(
                      child: Icon(
                        Icons.menu,
                        color:AppData.primaryColor,
                        size: 35,
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
          Container(
            child: _profilePage==CusProfilePages.SelectLocation?
            SelectLocation(
              // trip: _trip, 
              nextPage: (selectedDeparture,selectedArrive,selectedDate){
                setState(() {
                  _title = "Select Bus";
                  _profilePage=CusProfilePages.SelectBus;
                  _selectedArrive = selectedArrive;
                  _selectedDate =selectedDate;
                  _selectedDeparture = selectedDeparture;
                });
              }, 
              selectedArrive: _selectedArrive, 
              selectedDate: _selectedDate, 
              selectedDeparture: _selectedDeparture,
            ):_profilePage==CusProfilePages.SelectBus?
            SelectBus(
              selectedArrive: _selectedArrive, 
              selectedDate: _selectedDate, 
              selectedDeparture: _selectedDeparture,
              nextPage: (Trip trip){
                _trip=trip;
                setState(() {
                  _title = "Select Seat";
                  _profilePage=CusProfilePages.SelectSeat;
                });
              }
            ):_profilePage==CusProfilePages.SelectSeat?
            SelectSeat(
              trip: _trip, 
              nextPage: (List<Seat> seatList){
                _trip.seatList = seatList;
                setState(() {
                  _title = "Confirm Payment";
                  _profilePage=CusProfilePages.PayForSeat;
                });
              }, 
              user: widget.user,
            ):_profilePage==CusProfilePages.PayForSeat?
            Summery(
              trip: _trip, 
              user: widget.user,
              nextPage: (){
                widget.listener.moveToPage(CusProfilePages.BookedTrip);
              }
            ):
            Container(),
          ),
        ],
      ),
    );
  }
}