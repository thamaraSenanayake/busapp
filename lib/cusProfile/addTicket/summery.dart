import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/res/stripeServices.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

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
  Token _paymentToken;
  double _total = 0.0;
  bool _loading = false;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<bool> _payment() async {
    StripeTransactionResponse response = await StripeService.payWithNewCard(amount:_total.round().toString(),currency:"USD");
    if(!response.success){
      showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Failed to pay for the tickets'),
          content: new Text(response.message),
          actions: <Widget>[
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Text("Ok"),
            ),
          ],
        ),
      );
      return false;
    }else{
      return true;
    }
  }

  _sendNotification() async {

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Colombo"));

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false
      );

    const IOSNotificationDetails notificationDetails = IOSNotificationDetails(badgeNumber: 1);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,iOS: notificationDetails);
    for (var item in widget.trip.seatList) {
      if(item.status == 4){
        DateTime notificationTime = item.arriveTime.subtract(Duration(minutes: 15));
        await flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          '${widget.trip.startLocation}-${widget.trip.endLocation}',
          'Bus will arrived to ${item.getInPlace} within 10-15 minutes',
          tz.TZDateTime.local(notificationTime.year,notificationTime.month,notificationTime.day,notificationTime.hour,notificationTime.minute,notificationTime.second),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:UILocalNotificationDateInterpretation.absoluteTime,
          payload: 'item x'
        );
      }
      
    }
  }

  _doThePayment() async {
    setState(() {
      _loading = true;
    });
    if(await _payment()) {
      await _sendNotification();

      List<String> userList = [];
      userList = widget.trip.userList;
      if(!userList.contains(widget.user.email)){
        userList.add(widget.user.email);
      }
      Database().bookSeat(widget.trip.seatList, userList, widget.trip.id);
      setState(() {
        _loading = false;
      });

      widget.nextPage();
    }
    setState(() {
      _loading = false;
    });
  }
  
  _initSeat(){

    for (var item in widget.trip.seatList) {
      if(item.status == 4){
        _total += item.ticketPrice;
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
    StripeService.init();
    _initSeat();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;
    });
    return Stack(
      children: [
        Container(
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
        ),

        _loading?Container(
          height: _height-168,
          color: Color.fromRGBO(128, 128, 128, 0.3),
          child: SpinKitDoubleBounce(
            color: AppData.primaryColor2,
            size: 50.0,
          ),
        ):Container()
      ],
    );
  }
}