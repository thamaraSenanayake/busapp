import 'package:flutter/material.dart';
import 'package:quickbussl/const.dart';
import 'package:quickbussl/model/seat.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/module/customButton.dart';

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
  List<Seat> seatCount = [];
  Widget _seats;

  _smallBus(){
    _rowHeight = (_height-230)/10;
    _seatHeight = _rowHeight - 4;
    

    _seats =
      Column(
        children: [
          smallBusRow([0],seatCount[0].status,null, null),
          smallBusRow([1,2,3],seatCount[1].status,seatCount[2].status, seatCount[3].status),
          smallBusRow([4,5,6],seatCount[4].status,seatCount[5].status, seatCount[6].status),
          smallBusRow([7,8,9],seatCount[7].status,seatCount[8].status, seatCount[9].status),
          smallBusRow([10,11,12],seatCount[10].status,seatCount[11].status, seatCount[12].status),
          smallBusRow([13,14,15],seatCount[13].status,seatCount[14].status, seatCount[15].status),
          smallBusRow([16,17,18],seatCount[16].status,seatCount[17].status, seatCount[18].status),
          smallBusRow([19,20,21],seatCount[19].status,seatCount[20].status, seatCount[21].status),
          smallBusRow([22,23,24],seatCount[22].status,seatCount[23].status, seatCount[24].status),
          smallBusRow([25,27,28,26],seatCount[25].status,seatCount[27].status, seatCount[28].status,four:seatCount[26].status),
        ],
      );
      setState(() {
        
      });
  }

  Widget smallBusRow(List<int> index,int one,int two, int three,{int four}){
    return(
      Container(
        width: _width - 40,
        height:_rowHeight,
        child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              one != null? Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: (){
                    seatCount[index[0]].status = 4;
                    _smallBus();
                  },
                  child: Container(
                    height: _seatHeight,
                    width:_seatHeight,
                    color: one == 0 || one == 4?AppData.greenColor:AppData.primaryColor ,
                    child:Stack(
                      children:[
                       Padding(
                         padding: const EdgeInsets.all(3.0),
                         child: Text(
                           index[0].toString(),
                      style: TextStyle(color: AppData.whiteColor,fontSize:15),
                         ),
                       ), 
                      
                    one == 1 || one == 3?
                    Center(
                      child: Icon(
                        Icons.event_seat_sharp,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):one == 4? Center(
                      child: Icon(
                        Icons.check,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):Container(),])
                  ),
                ),
              ):Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: _seatHeight,
                  width:_seatHeight,
                ),
              ),
              four == null ?Expanded(
                child: Container(
                  height: _seatHeight,
                ),
              ):Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: (){
                    seatCount[index[3]].status = 4;
                    _smallBus();
                  },
                  child: Container(
                    height: _seatHeight,
                    width:_seatHeight,
                    color: four == 0 || four == 4?AppData.greenColor:AppData.primaryColor ,
                    child:Stack(
                      children:[
                       Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          index[3].toString(),
                          style: TextStyle(color: AppData.whiteColor,fontSize:15),
                        ),
                       ), 
                      
                    four == 1 || four == 3?
                    Center(
                      child: Icon(
                        Icons.event_seat_sharp,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):four == 4? Center(
                      child: Icon(
                        Icons.check,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):Container(),])
                  ),
                ),
              ),
              two != null? Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: (){
                    seatCount[index[1]].status = 4;
                    _smallBus();
                  },
                  child: Container(
                    height: _seatHeight,
                    width:_seatHeight,
                    color: two == 0 || two == 4?AppData.greenColor:AppData.primaryColor ,
                    child:Stack(
                      children:[
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            index[1].toString(),
                            style: TextStyle(color: AppData.whiteColor,fontSize:15),
                          ),
                        ), 
                      
                    two == 1 || two == 3?
                    Center(
                      child: Icon(
                        Icons.event_seat_sharp,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):two == 4? Center(
                      child: Icon(
                        Icons.check,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):Container(),])
                  ),
                ),
              ):Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: _seatHeight,
                  width:_seatHeight,
                ),
              ),
             three != null? Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: (){
                    seatCount[index[2]].status = 4;
                    _smallBus();
                  },
                  child: Container(
                    height: _seatHeight,
                    width:_seatHeight,
                    color: three == 0 || three == 4?AppData.greenColor:AppData.primaryColor ,
                    child:Stack(
                      children:[
                       Padding(
                         padding: const EdgeInsets.all(3.0),
                         child: Text(
                           index[2].toString(),
                      style: TextStyle(color: AppData.whiteColor,fontSize:15),
                         ),
                       ), 
                      
                    three == 1 || three == 3?
                    Center(
                      child: Icon(
                        Icons.event_seat_sharp,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):three == 4? Center(
                      child: Icon(
                        Icons.check,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):Container(),])
                  ),
                ),
              ):Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: _seatHeight,
                  width:_seatHeight,
                ),
              )
            ],
          )
      )
    );

  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 29; i++) {
      if(i % 3 == 0){
        seatCount.add(
          Seat()
          ..status = 1
        );
      }else{
        seatCount.add(
          Seat()
          ..status = 0
        );
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      _smallBus();
    });
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;
    });
    return Expanded(
      child: Column(
        children: [
          Container(
            width: _width,
            // height: _height-166,
            // color: Colors.red,
            child: _seats,
          ),
          Padding(
            padding: const EdgeInsets.only(top:5.0),
            child: CustomButton(text: "Done", buttonClick: (){widget.nextPage(1);}),
          )
        ],
      ),
    );
  }
}