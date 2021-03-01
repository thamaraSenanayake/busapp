import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickbussl/model/seat.dart';

class Trip{
  String busOwnerEmail;
  DateTime startTime;
  DateTime endTime;
  DateTime travelDate;
  String startLocation;
  String endLocation;
  LatLng startPosition;
  LatLng endPosition;
  LatLng currentLocation;
  BusType busType;
  List<Seat> seatList;
  List<String> userList;
  String busName;
  bool highWayBus;
  String id;
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