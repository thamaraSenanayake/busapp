import 'package:flutter/material.dart';
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
    widget.nextPage();
  }
  
  _initSeat(){

    for (var i = 0; i < 11; i++) {
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
                  i.toString(),
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
                    "Colombo To Badulla",
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
                    "10.00 AM",
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
                    "Rs. 200.00",
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