import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickbussl/model/seat.dart';

class Trip{
  String busOwnerEmail;
  DateTime startTime;
  DateTime endTime;
  DateTime travelDate;
  String startLocation;
  String endLocation;
  LatLng currentLocation;
  BusType busType;
  List<Seat> seatCount;
  List<String> userList;
  String busName;
}

enum BusType{
  Small,
  Medium,
  Large
}

class BusSeatCount{
  static const int SMALL = 10;
  static const int MEDIUM = 20;
  static const int LARGE = 30;
}