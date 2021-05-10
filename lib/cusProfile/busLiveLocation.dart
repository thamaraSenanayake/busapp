
import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickbussl/const.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/module/topBar.dart';
import 'dart:ui' as ui;

import 'package:quickbussl/res/typeConvert.dart';

class BusLocation extends StatefulWidget {
  final Trip trip;
  BusLocation({Key key, this.trip}) : super(key: key);

  @override
  _BusLocationState createState() => _BusLocationState();
}

class _BusLocationState extends State<BusLocation> {
  // CameraPosition  cameraPosition;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController mapController;
  String _mapStyle;
  LatLng _position;
  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  bool _displayBottomBar = false;
  
  double _width= 0;


  _addMark(LatLng position) async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/bus.png', 100);
    markers.remove("YOUR_LOCATION");
    var marker = Marker(
      markerId: MarkerId("YOUR_LOCATION"),
      position: LatLng(position.latitude,position.longitude),
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );

    setState(() {
      markers[MarkerId("YOUR_LOCATION")] = marker;
    });
  }


  _createPolylines(LatLng start, LatLng destination) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      AppData.kGoogleApiKey, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
    setState(() {
      
    });
  }
  
  
  
  _getLiveLocation(){
    CollectionReference tripList = Database().trips;
     tripList
    .document(widget.trip.id)
    .snapshots().listen((querySnapshot) {
      if(querySnapshot["currentLocation"] != null){
        _position = TypeConvert().stringToLatLng(querySnapshot["currentLocation"]);
        _addMark(_position);
      }

    });
  }
 

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    _createPolylines( widget.trip.startPosition,  widget.trip.endPosition);
    _getLiveLocation();
  }
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            TopBarModule(
              title: "Bus Location", 
              buttonClick: (){
                Navigator.pop(context);
              }, 
              iconData: Icons.arrow_back
            ),
            Expanded(
              child:Stack(
                children: [
                  Container(
                    child: GoogleMap(
                      polylines: Set<Polyline>.of(polylines.values),
                      initialCameraPosition: CameraPosition(
                        target: LatLng( 6.927079,79.861244),
                        zoom: 8
                      ),
                      onMapCreated: _onMapCreated,
                      mapToolbarEnabled: true,
                      markers: Set<Marker>.of(markers.values),
                      onTap: (latLng){
                        if(_displayBottomBar){
                          setState(() {
                            _displayBottomBar = false;
                          });
                        }
                      },
                    ),
                  ),

                  
                ],
              ) 
            )
          ],
        ),
      ),
    );
  }
  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      // controller.setMapStyle(_mapStyle);
    });

    List<LatLng> _latLngList = [widget.trip.startPosition,widget.trip.endPosition];
    LatLngBounds bound = _boundsFromLatLngList(_latLngList);
    // if(latLng_2.longitude > latLng_1.longitude){
    //   bound = LatLngBounds(southwest: latLng_2, northeast: latLng_1);
    // }else{
    //   bound = LatLngBounds(southwest: latLng_1, northeast: latLng_2);
    // }


    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);
    this.mapController.animateCamera(u2);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  
}