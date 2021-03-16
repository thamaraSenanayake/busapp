import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:quickbussl/busowner/profileBase.dart';
import 'package:quickbussl/database/apiCall.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/module/customDatePicker.dart';
import 'package:quickbussl/module/customTimePicker.dart';
import 'package:quickbussl/module/getLocation.dart';
import 'package:quickbussl/module/textbox.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../const.dart';

class AddTrip extends StatefulWidget {
  final User user;
  final BusOwnerProfileBaseListener listener;
  AddTrip({Key key,@required this.listener,@required this.user}) : super(key: key);

  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  var chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  int _duration;
  double _width = 0.0;
  Trip _trip = Trip();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  String _startTimeError = '';
  String _endTimeError = '';
  String _travelDateError = '';
  String _startLocationError = '';
  String _endLocationError = '';
  String _ticketPriceError = '';
  TextEditingController _timeEstimate = TextEditingController();

  

  _done() async {
    FocusScope.of(context).unfocus();

    bool _validation = true;
    if(_trip.startLocation.isEmpty){
      setState(() {
        _startLocationError = "Required Field";
      });
      _validation = false;
    }
    if(_trip.endLocation.isEmpty){
      setState(() {
        _endLocationError = "Required Field";
      });
      _validation = false;
    }
    if(_trip.totalPrice == 0){
      setState(() {
        _ticketPriceError = "Required Field";
      });
      _validation = false;
    }
    if(_validation){
      Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);

      _trip.id = new DateTime.now().millisecondsSinceEpoch.toString();

      for (var i = 0; i < 10; i++) {
        _trip.id += chars[rnd.nextInt(chars.length)];
      }

      await Database().addTrip(_trip);
      widget.listener.moveToPage(BusOwnerPages.OnGoing);

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false
      );

      const IOSNotificationDetails notificationDetails = IOSNotificationDetails(badgeNumber: 1);
      const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,iOS: notificationDetails);
      DateTime notificationTime = _trip.startTime.subtract(Duration(minutes: 15));
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Reminder',
        'You have a trip to ${_trip.startLocation} at ${DateFormat.jm().format(_trip.startTime)} ',
        tz.TZDateTime.local(notificationTime.year,notificationTime.month,notificationTime.day,notificationTime.hour,notificationTime.minute,notificationTime.second),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'item x'
      );

    }
  }

  _setEndTime() async {
    if(_trip.startLocation.isNotEmpty && _trip.endLocation.isNotEmpty && _trip.endPosition != null && _trip.startTime != null ){
      DistanceValues _values = await getDistance(_trip.startPosition,_trip.endPosition ); 

      _trip.endTime = _trip.startTime.add(_values.duration);
      _trip.totalDistance = _values.distance/1;
      
      _timeEstimate.text = DateFormat.jm().format(_trip.endTime);
    }
    
  }

  _updateTime() async {
    if(_duration != null){

      _trip.endTime = _trip.startTime.add(Duration(seconds:_duration));
      
      _timeEstimate.text = DateFormat.jm().format(_trip.endTime);
    }
    
  }

  Future<void> _handlePressButton(String locationTyp) async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: AppData.kGoogleApiKey,
      onError: onError,
      mode: Mode.overlay,
      language: "en",
      components: [Component(Component.country, "lk")],
      logo: Container(height:0,width:0)
    );

    displayPrediction(p,locationTyp);
  }

   void onError(PlacesAutocompleteResponse response) {
    print(response.errorMessage);
  }

  Future<Null> displayPrediction(Prediction p,String locationType) async {
  if (p != null) {
    // get detail (lat/lng)
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: AppData.kGoogleApiKey,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;
    if(locationType == 'start'){
      setState(() {
        _trip.startPosition = LatLng(lat, lng);
        _trip.startLocation = detail.result.name;
        _startLocationError = "";
      });
    }else{
      setState(() {
        _trip.endPosition = LatLng(lat, lng);
        _trip.endLocation = detail.result.name;
        _endLocationError = "";
      });
    }
    _setEndTime();
    print(lat);
    print(lng);
    // scaffold.showSnackBar(
    //   SnackBar(content: Text("${p.description} - $lat/$lng")),
    // );
  }
}

  @override
  void initState() { 
    super.initState();
    _trip.startLocation = "";
    _trip.endLocation = "";
    _trip.totalPrice = 0;
    _trip.highWayBus = false;
    _trip.busOwnerEmail = widget.user.email;
    _trip.startTime = DateTime.now();
    _trip.endTime =DateTime.now().add(Duration(hours: 5));
    _trip.travelDate = DateTime.now();
    _trip.busName = widget.user.name;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Container(
      // color: Colors.blue,
       child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 5),
                child: Container(
                  width: _width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trip Start Location: ",
                        style: TextStyle(
                          color: AppData.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          backgroundColor: Colors.white
                        ),
                      ),
                      Text(
                        _startLocationError,
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
              GetLocation(
                setLocation: (detail,latLng){
                  setState(() {
                    _trip.startPosition = latLng;
                    _trip.startLocation = detail;
                    _startLocationError = "";
                  });
                }, 
                initLocation: null
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 5),
                child: Container(
                  width: _width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trip End Location: ",
                        style: TextStyle(
                          color: AppData.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          backgroundColor: Colors.white
                        ),
                      ),
                      Text(
                        _endLocationError,
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
              GetLocation(
                setLocation: (detail,latLng){
                  setState(() {
                    _trip.endPosition = latLng;
                    _trip.endLocation = detail;
                    _endLocationError = "";
                  });
                }, 
                initLocation: null
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 5),
                child: Container(
                  width: _width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trip Date: ",
                        style: TextStyle(
                          color: AppData.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          backgroundColor: Colors.white
                        ),
                      ),
                      Text(
                        _travelDateError,
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
                  _trip.travelDate = val;
                  _updateTime();
                }, 
                title: "Date:"
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 5),
                child: Container(
                  width: _width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trip Start Time: ",
                        style: TextStyle(
                          color: AppData.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          backgroundColor: Colors.white
                        ),
                      ),
                      Text(
                        _startTimeError,
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
              CustomTimePicker(
                initTime: TimeOfDay.now(), 
                onChange: (val){
                  _trip.startTime =DateTime(_trip.travelDate.year,_trip.travelDate.month,_trip.travelDate.day, val.hour, val.minute);
                  _setEndTime();
                }, 
                title: "Time"
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 0),
                child: Container(
                  width: _width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Estimate Travel End Time : ",
                        style: TextStyle(
                          color: AppData.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          backgroundColor: Colors.white
                        ),
                      ),
                      Text(
                        "",
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
              TextBox(
                shadowDisplay: false,
                textBoxKey: null, 
                textEditingController: _timeEstimate,
                onChange: (val){

                }, 
                errorText: "",
                enable: false,
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 0),
                child: Container(
                  width: _width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Full ticket price : ",
                        style: TextStyle(
                          color: AppData.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          backgroundColor: Colors.white
                        ),
                      ),
                      Text(
                        _ticketPriceError,
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
              TextBox(
                shadowDisplay: false,
                textBoxKey: null, 
                textInputType: TextInputType.number,
                onChange: (val){
                  if(val.isNotEmpty){
                    _trip.totalPrice = double.parse(val);
                  }
                }, 
                errorText: "",
              ),

              CheckboxListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left:5.0),
                  child: Text(
                    "Highway bus : ",
                    style: TextStyle(
                      color: AppData.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.white
                    ),
                  ),
                ),
                value: _trip.highWayBus, 
                activeColor:AppData.primaryColor,
                onChanged: (val){
                  setState(() {
                    _trip.highWayBus = val;
                  });
                  
                }
              ),

              SizedBox(height:50),

              CustomButton(
                text: "Done", 
                shadow: false,
                buttonClick: (){
                  _done();
                }
              )

             ],
           ),
        ),
       ),
    );
  }
}