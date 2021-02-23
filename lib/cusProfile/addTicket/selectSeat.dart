import 'package:flutter/material.dart';
import 'package:quickbussl/const.dart';
import 'package:quickbussl/model/trip.dart';

class SelectSeat extends StatefulWidget {
  final Trip trip;
  final Function(int) nextPage; 
  SelectSeat({Key key,@required this.trip,@required this.nextPage}) : super(key: key);

  @override
  _SelectSeatState createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  double _width = 0.0;
  double _seatHeight = 10.0;
  double _rowHeight = 14.0;
  double _height = 0;

  Widget smallBus(){
    _rowHeight = (_height-170)/10;
    _seatHeight = _rowHeight - 4;
    return(
      Column(
        children: [
          smallBusRow(0,0, 0),
          smallBusRow(0,0, 0),
          smallBusRow(0,0, 0),
          smallBusRow(0,0, 0),
          smallBusRow(0,0, 0),
          smallBusRow(0,0, 0),
          smallBusRow(0,0, 0),
          smallBusRow(0,0, 0),
          smallBusRow(0,0, 0),
          smallBusRow(0,0, 0),
        ],
      )
    );
  }

  Widget smallBusRow(int one,int two, int three){
    return(
      Container(
        width: _width - 40,
        height:_rowHeight,
        child:
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: _seatHeight,
                  width:_seatHeight,
                  color: one == 0?AppData.greenColor:AppData.primaryColor ,
                ),
              ),
              Expanded(
                child: Container(
                  height: _seatHeight,
                  // width:_seatHeight,
                  // color: Colors.,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: _seatHeight,
                  width:_seatHeight,
                  color: two == 0?AppData.greenColor:AppData.primaryColor ,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: _seatHeight,
                  width:_seatHeight,
                  color: three == 0?AppData.greenColor:AppData.primaryColor ,
                ),
              )
            ],
          )
      )
    );

  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;
    });
    return Expanded(
      child: Container(
        width: _width,
        // height: _height-166,
        // color: Colors.red,
        child: smallBus(),
      ),
    );
  }
}