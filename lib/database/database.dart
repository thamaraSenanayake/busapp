import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:quickbussl/model/seat.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/res/typeConvert.dart';

class Database{
  final CollectionReference users = Firestore.instance.collection('user');
  final CollectionReference trips = Firestore.instance.collection('trip');

  Future<User> login(String email, String password ) async{
    QuerySnapshot querySnapshot;

    querySnapshot = await users
    .where('email',isEqualTo: email )
    .where('password',isEqualTo: password)
    .getDocuments();

    if(querySnapshot.documents.length == 0){
      return null;
    }
      
    return _setUser(querySnapshot);;
  }

  Future<User> _setUser(QuerySnapshot querySnapshot) async {
    User user;
    for (var item in querySnapshot.documents) {
      
      user = User()
        ..email = item["email"]
        ..name = item["name"]
        ..password = item["password"]
        ..idNum = item["idNum"]
        ..phone = item["phone"]
        ..userType =TypeConvert().stringToUserType(item["userType"]);
    }

    return user;
  }

  Future addUser(User user) async{
    await users.document(user.email).setData({
      "email":user.email,
      "name":user.name,
      "password":user.password,
      "idNum":user.idNum,
      "phone":user.phone,
      "userType":TypeConvert().userTypeToString( user.userType),
    });
  }

  

  Future updateUser(User user) async{
    await users.document(user.email).updateData({
      "name":user.name,
      "idNum":user.idNum,
      "phone":user.phone,
    });
  }

  Future changePassword(User user) async{
    await users.document(user.email).updateData({
      "password":user.password,
    });
  }

  Future bookSeat(List<Seat> seatList,List<String> userList,String tripId) async {
    List<Map<String,dynamic>> seats =[];
    for (var item in seatList) {
      seats.add(
        {
          "email":item.email,
          "number":item.number,
          "status":item.status == 4?1:item.status,
          "getInLocation":item.getInLocation != null? TypeConvert().latLngToString(item.getInLocation):"",
          "getOutLocation":item.getOutLocation != null? TypeConvert().latLngToString(item.getOutLocation):"",
          "getInPlace":item.getInPlace,
          "getOutPlace":item.getOutPlace,
        }
      );
    }

    await trips.document(tripId).updateData({
      'seatList':seats,
      'userList':userList
    });
  }

  
  Future addTrip(Trip trip) async{
    List<Map<String,dynamic>> seatList =[];
    for (var i = 0; i < 29; i++) {
      seatList.add(
        {
          "email":"",
          "number":(i+1),
          "status":0,
          "getInLocation":"",
          "getOutLocation":"",
          "getInPlace":"",
          "getOutPlace":"",
        }
      );
    }
    await trips.document(trip.id).setData({
      "busOwnerEmail":trip.busOwnerEmail,
      "startTime":trip.startTime,
      "endTime":trip.endTime,
      "travelDate":trip.travelDate,
      "startLocation":trip.startLocation,
      "endLocation":trip.endLocation,
      "currentLocation":trip.currentLocation,
      "busType":"BusType.Small",
      "seatList":seatList,
      "userList":[],
      "busName":trip.busName,
      "highWayBus":trip.highWayBus,
      "id":trip.id,
      "startPosition":TypeConvert().latLngToString(trip.startPosition),
      "endPosition":TypeConvert().latLngToString(trip.endPosition),
    });
  }

  Future<List<Trip>> searchTrip(String startLocation,String endLocation,DateTime date) async {
    QuerySnapshot querySnapshot;
    final timestamp = Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);
    final timestampNextDate = Timestamp.fromMillisecondsSinceEpoch(date.add(Duration(days: 1)).millisecondsSinceEpoch);
    print(DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch).day);
    print(DateTime.fromMillisecondsSinceEpoch(timestampNextDate.millisecondsSinceEpoch).day);
    querySnapshot = await trips
    .where('startLocation',isEqualTo: startLocation)
    .where('endLocation',isEqualTo: endLocation)
    .where('travelDate',isGreaterThanOrEqualTo:timestamp)
    .where('travelDate',isLessThan:timestampNextDate)
    .getDocuments();

    return _setTrip(querySnapshot);
  }

  Future<List<String>> getLocationList() async {
    QuerySnapshot querySnapshot;
    List<String> _locationList = [];
    final startAtTimestamp = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);

    querySnapshot = await trips
    .where('travelDate',isGreaterThanOrEqualTo:startAtTimestamp)
    .getDocuments();

    for (var item in querySnapshot.documents) {
      _locationList.add(item['startLocation']);
      _locationList.add(item['endLocation']);
    }

    return _locationList;
  }

  Future<List<Trip>> bookedTripCustomer(String userEmail) async {
    QuerySnapshot querySnapshot;
    final timestamp = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    querySnapshot = await trips
    .where('userList',arrayContains: userEmail)
    .where('travelDate',isGreaterThanOrEqualTo:timestamp)
    .getDocuments();

    return _setTrip(querySnapshot);
  }

  Future<List<Trip>> tripHistoryCustomer(String userEmail) async {
    QuerySnapshot querySnapshot;
    final timestamp = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    querySnapshot = await trips
    .where('userList',arrayContains: userEmail)
    .where('travelDate',isLessThan:timestamp)
    .getDocuments();

    return _setTrip(querySnapshot);
  }
  Future<List<Trip>> onGoingTripBusOwner(String userEmail) async {
    QuerySnapshot querySnapshot;
    final timestamp = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    querySnapshot = await trips
    .where('busOwnerEmail',arrayContains: userEmail)
    .where('travelDate',isGreaterThanOrEqualTo:timestamp)
    .getDocuments();

    return _setTrip(querySnapshot);
  }

  Future<List<Trip>> pastTripBusOwner(String userEmail) async {
    QuerySnapshot querySnapshot;
    final timestamp = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    querySnapshot = await trips
    .where('busOwnerEmail',arrayContains: userEmail)
    .where('travelDate',isLessThan:timestamp)
    .getDocuments();

    return _setTrip(querySnapshot);
  }

  Future setLiveLocation(LatLng position,String tripId) async {
    await trips.document(tripId).updateData({
      'currentLocation':TypeConvert().latLngToString(position),
    });
  }

  

  List<Trip> _setTrip(QuerySnapshot querySnapshot) {
    List<Trip> tripList =[];

    for (var item in querySnapshot.documents) {
      List<Seat> seatList =[];
      Timestamp startTime = item['startTime'];
      Timestamp travelDate = item['travelDate'];
      Timestamp endTime = item['endTime'];
      
      for (var seat in item['seatList']) {

        seatList.add(
          Seat()..email = seat["email"]
            ..number = seat["number"]
            ..status = seat["status"]
            ..getInLocation = seat["getInLocation"].toString().isNotEmpty? TypeConvert().stringToLatLng(seat["getInLocation"]):null
            ..getOutLocation = seat["getOutLocation"].toString().isNotEmpty? TypeConvert().stringToLatLng(seat["getOutLocation"]):null
            ..getInPlace = seat["getInPlace"]
            ..getOutPlace = seat["getOutPlace"]
        );

      }
      tripList.add(
        Trip()
        ..busOwnerEmail = item['busOwnerEmail']
        ..startTime = DateTime.fromMillisecondsSinceEpoch(startTime.millisecondsSinceEpoch) 
        ..endTime =  DateTime.fromMillisecondsSinceEpoch(endTime.millisecondsSinceEpoch)
        ..travelDate = DateTime.fromMillisecondsSinceEpoch(travelDate.millisecondsSinceEpoch) 
        ..startLocation = item['startLocation']
        ..endLocation = item['endLocation']
        ..startPosition =TypeConvert().stringToLatLng(item["startPosition"]) 
        ..endPosition = TypeConvert().stringToLatLng(item["endPosition"])  
        ..currentLocation = item['currentLocation']
        ..busType =TypeConvert().stringToBusType(item['busType'])
        ..seatList = seatList
        ..userList = item['userList'].cast<String>()
        ..busName = item['busName']
        ..highWayBus = item['highWayBus']
        ..id = item['id']
      );
    }

    return tripList;
    
  }
}