import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/customButton.dart';

import '../../const.dart';

class Summery extends StatefulWidget {
  final Trip trip;
  final Function() nextPage;
  final User user;
  Summery({Key key,@required this.trip,@required this.nextPage,@required this.user}) : super(key: key);

  @override
  _SummeryState createState() => _SummeryState();
}

class _SummeryState extends State<Summery> {
  double _width = 0.0;
  double _height =0.0;
  List<Widget> _rowList = [];

  _doThePayment(){
    List<String> userList = [];
    userList = widget.trip.userList;
    if(!userList.contains(widget.user.email)){
      userList.add(widget.user.email);
    }
    Database().bookSeat(widget.trip.seatList, userList, widget.trip.id);
    widget.nextPage();
  }
  
  _initSeat(){

    for (var item in widget.trip.seatList) {
      if(item.status == 4){
        _rowList.add(
          Padding(
            padding: const EdgeInsets.only(bottom:10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  // color: Colors.red,
                  child:Text(
                    item.number.toString(),
                    style: TextStyle(
                      color: AppData.blackColor,
                      fontSize: 18,
                      // fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Container(
                    // color: Colors.green,
                    child:Text(
                      item.getInPlace+" To "+item.getOutPlace,
                      style: TextStyle(
                        color: AppData.blackColor,
                        fontSize: 18,
                        // fontWeight: FontWeight.w500,
                      ),
                      // textAlign: TextAlign.center,
                    ),
                  )
                ),
                Expanded(
                  child: Container(
                    // color: Colors.indigo,
                    child:Text(
                      DateFormat.jm().format(item.arriveTime),
                      style: TextStyle(
                        color: AppData.blackColor,
                        fontSize: 18,
                        // fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
                Expanded(
                  child: Container(
                    // color: Colors.orange,
                    child:Text(
                      "Rs."+item.ticketPrice.toStringAsFixed(0)+'/=',
                      style: TextStyle(
                        color: AppData.blackColor,
                        fontSize: 18,
                        // fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
              ],
            ),
          )
        );  
        
      }
    }

    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    _initSeat();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;
    });
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      width: _width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text:TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Name: ",
                  style: TextStyle(
                    color: AppData.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                  ),
                ),
                TextSpan(
                  text: widget.user.name,
                  style: TextStyle(
                    color: AppData.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          RichText(
            text:TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Contact num: ",
                  style: TextStyle(
                    color: AppData.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                  ),
                ),
                TextSpan(
                  text: widget.user.phone,
                  style: TextStyle(
                    color: AppData.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          RichText(
            text:TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Email: ",
                  style: TextStyle(
                    color: AppData.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                  ),
                ),
                TextSpan(
                  text: widget.user.email,
                  style: TextStyle(
                    color: AppData.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height:40
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  // color: Colors.red,
                  child:Text(
                    "Seat No",
                    style: TextStyle(
                      color: AppData.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Container(
                    // color: Colors.green,
                    child:Text(
                      "Travel to",
                      style: TextStyle(
                        color: AppData.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
                Expanded(
                  child: Container(
                    // color: Colors.indigo,
                    child:Text(
                      "Time",
                      style: TextStyle(
                        color: AppData.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
                Expanded(
                  child: Container(
                    // color: Colors.orange,
                    child:Text(
                      "Cost",
                      style: TextStyle(
                        color: AppData.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
              ],
            ),
          ),
          Container(
            height: _height-465,
            width: _width,
            child: SingleChildScrollView(
              child: Column(
                children: _rowList,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical:10.0),
            child: Text(
              "Can't Change the seat number or cancel the booking after payment",
              style: TextStyle(
                color: AppData.blackColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          CustomButton(text: "Pay now", buttonClick: (){_doThePayment();})
          
        ],
      ),
    );
  }
}