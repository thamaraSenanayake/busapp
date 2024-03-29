import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/customButton.dart';

import '../const.dart';

class BusTripDisplay extends StatefulWidget {
  final Trip busTrip;
  final UserType userType;
  final BusTripDisplayListener listener;
  BusTripDisplay({Key key,@required this.busTrip,@required this.listener,@required this.userType}) : super(key: key);

  @override
  _BusTripDisplayState createState() => _BusTripDisplayState();
}

class _BusTripDisplayState extends State<BusTripDisplay> {
  double _width = 0.0;
  double _income = 0.0;
  int _availableSeat = 0; 
  bool _isActiveTrip = false;
  String _buttonText = "";
  String _totalDistance = "";
  String _ticketPrice = "";

  @override
  void initState() { 
    super.initState();
    _setAvailableSeat();
    _checkActiveVisit();    
    _totalIncome();
    if(widget.busTrip.totalDistance != null){
      _totalDistance = (widget.busTrip.totalDistance/1000).toStringAsFixed(2);
    }else{
      _totalDistance = "0";
    }
    if(widget.busTrip.totalPrice != null){
      _ticketPrice = (widget.busTrip.totalPrice).toStringAsFixed(2);
    }else{
      _ticketPrice = "0";
    }
  }
  _totalIncome(){
    for (var item in widget.busTrip.seatList) {
      if(item.status == 1 && item.ticketPrice != null){
        _income += item.ticketPrice;
      }
    }
  }
  _checkActiveVisit(){
    if(widget.busTrip.startTime.isBefore(DateTime.now()) && widget.busTrip.endTime.isAfter(DateTime.now()) ){
      setState(() {
        _isActiveTrip = true;
      });
      if(widget.userType == UserType.Passenger){
        setState(() {
          _buttonText = "Check bus location";
        });
      }
      else if(widget.userType == UserType.BusOwner && widget.busTrip.currentLocation == null){
        setState(() {
          _buttonText = "Start Trip";
        });
      }
      else if(widget.userType == UserType.BusOwner && widget.busTrip.currentLocation != null){
        setState(() {
          _buttonText = "";
          _isActiveTrip = false;
        });
      }
    }
  }
  
  _setAvailableSeat(){
    for (var item in widget.busTrip.seatList) {
      if(item.status == 0){
        _availableSeat++;
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    setState(() {
        _width = MediaQuery.of(context).size.width;
    });
    return Padding(
      padding: const EdgeInsets.only(top:10.0),
      child: GestureDetector(
        onTap: (){
          widget.listener.busTripClick(widget.busTrip);
        },
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:10,vertical:5),
            width: _width-40,
            decoration: BoxDecoration(
              color: AppData.whiteColor,
              border: Border.all(
                color: AppData.primaryColor2,
                width: 2
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.busTrip.busName,
                  style: TextStyle(
                    color: AppData.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                widget.busTrip.endTime.difference(DateTime.now()).inSeconds>1? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.airline_seat_recline_normal_sharp,
                      size: 150, 
                      color: AppData.greenColor,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.timer,
                                color: AppData.primaryColor2,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              RichText(
                                text:TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "At ",
                                      style: TextStyle(
                                        color: AppData.blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300
                                      ),
                                    ),
                                    TextSpan(
                                      text: DateFormat.jm().format(widget.busTrip.startTime),
                                      style: TextStyle(
                                        color: AppData.blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text:TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: _availableSeat.toString()+"/",
                                style: TextStyle(
                                  color: AppData.blackColor,
                                  fontSize: 60,
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                              TextSpan(
                                text: '29 Seats left',
                                style: TextStyle(
                                  color: AppData.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ):Container(),
                
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child:Text(
                    (widget.busTrip.endTime.difference(DateTime.now()).inSeconds>1?'Traveling date ':'Traveled date ')+DateFormat.yMEd().format(widget.busTrip.travelDate) ,
                    style: TextStyle(
                      color: AppData.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppData.primaryColor2,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RichText(
                            text:TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Start from ",
                                  style: TextStyle(
                                    color: AppData.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300
                                  ),
                                ),
                                TextSpan(
                                  text: widget.busTrip.startLocation,
                                  style: TextStyle(
                                    color: AppData.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 125,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.timer,
                            color: AppData.primaryColor2,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RichText(
                            text:TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "At ",
                                  style: TextStyle(
                                    color: AppData.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300
                                  ),
                                ),
                                TextSpan(
                                  text:  DateFormat.jm().format(widget.busTrip.startTime),
                                  style: TextStyle(
                                    color: AppData.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 5,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppData.primaryColor2,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RichText(
                            text:TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Arrive to ",
                                  style: TextStyle(
                                    color: AppData.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300
                                  ),
                                ),
                                TextSpan(
                                  text: widget.busTrip.endLocation,
                                  style: TextStyle(
                                    color: AppData.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 125,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.timer,
                            color: AppData.primaryColor2,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RichText(
                            text:TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "At ",
                                  style: TextStyle(
                                    color: AppData.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300
                                  ),
                                ),
                                TextSpan(
                                  text:  DateFormat.jm().format(widget.busTrip.endTime),
                                  style: TextStyle(
                                    color: AppData.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
              
                Container(
                  width: _width -40,
                  child: Center(
                    child: Text(
                      widget.userType != UserType.BusOwner? "Total distance:Km $_totalDistance \n Full Ticket price:Rs $_ticketPrice/=":
                      "Total income from trip: Rs "+ _income.toStringAsFixed(2),
                      style: TextStyle(
                        color: AppData.blackColor,
                        fontSize: 18,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                _isActiveTrip?Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: CustomButton(
                    text: widget.userType == UserType.BusOwner? "Start Trip":"Check Bus Location", 
                    shadow: false,
                    buttonClick: (){
                      widget.listener.busTripClick(widget.busTrip);
                    }
                  ),
                ):Container()


              ],
            ),
          ),
        ),
      ),
    );
  }
}

abstract class BusTripDisplayListener{
  busTripClick(Trip busTrip);
  locationGetOrSet(Trip busTrip);
}