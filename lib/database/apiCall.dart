import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../const.dart';


Future<int> getDistance(LatLng start ,LatLng end) async{
  var url ="https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${start.latitude},${start.longitude}&destinations=${end.latitude}%2C${end.longitude}%7C&key=${AppData.kGoogleApiKey}";

  //send to server DB
  final response = await http.get(
    url,
    headers: {"Content-Type": "application/json"},
  );

  var body = json.decode(response.body.toString());
  print(body["rows"][0]["elements"][0]["distance"]["value"]);
  print(body["rows"][0]["elements"][0]["duration"]["value"]);

  return body["rows"][0]["elements"][0]["duration"]["value"];
}

// {
//    "destination_addresses" : [ "Unnamed Road, Badulla, Sri Lanka" ],
//    "origin_addresses" : [ "Sri Lanka" ],
//    "rows" : [
//       {
//          "elements" : [
//             {
//                "distance" : {
//                   "text" : "223 mi",
//                   "value" : 359054
//                },
//                "duration" : {
//                   "text" : "5 hours 48 mins",
//                   "value" : 20897
//                },
//                "status" : "OK"
//             }
//          ]
//       }
//    ],
//    "status" : "OK"
// }