import 'package:google_maps_flutter/google_maps_flutter.dart';

class Seat{
  String email;
  int number;
  int status;
  LatLng location;
}

// status = 3 unavailable 
// status = 1 booked
// status = 0 not booked
// status = 4 booked now 