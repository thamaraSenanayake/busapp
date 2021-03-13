
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickbussl/const.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/module/locationError.dart';
import 'package:quickbussl/module/topBar.dart';
import 'dart:ui' as ui;

class DisplayPassengers extends StatefulWidget {
  final Trip trip;
  DisplayPassengers({Key key, this.trip}) : super(key: key);

  @override
  _DisplayPassengersState createState() => _DisplayPassengersState();
}

class _DisplayPassengersState extends State<DisplayPassengers> implements LocationErrorListener{
  CameraPosition  cameraPosition;
  LatLng _currentLatLang;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController mapController;
  String _mapStyle;
  // Object for PolylinePoints
  PolylinePoints polylinePoints;

  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];

  // Map storing polylines created by connecting
  // two points
  Map<PolylineId, Polyline> polylines = {};

  _getCurrentPosition() async {
    print("get location");
    Position position;
    try{
      position = await getCurrentPosition(desiredAccuracy:LocationAccuracy.best);
    }
    catch (e){
      // Navigator.of(context).push(
      //   PageRouteBuilder(
      //     pageBuilder: (context, _, __) => LocationError(
      //       listener: this,
      //     ),
      //     opaque: false
      //   ),
      // );
      // return;
    }
    if(position != null){
      _addMark(LatLng(position.latitude, position.longitude));
    }
    
  }

  _loadShopsNearBy() async {
    
    final Uint8List markerIcon = await getBytesFromAsset('assets/user.png', 150);

    for (var item in widget.trip.seatList) {
      if(item.status == 1){
        var marker = Marker(
          markerId: MarkerId(item.number.toString()),
          position: LatLng(item.getInLocation.latitude,item.getInLocation.longitude),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: item.email,
            // snippet: item.shopAddress+"\nview shop...",
            anchor:Offset(0.5, 0.0), 
            onTap: (){
              // widget.signUpSignInListener.viewFooDMenu(item);
            }
          )
        );
        markers[MarkerId(item.number.toString())] = marker;
      }
    }
    setState(() {
      
    });
  }

  _addMark(LatLng position) async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/bus.png', 100);
    markers.remove("YOUR_LOCATION");
    var marker = Marker(
      markerId: MarkerId("YOUR_LOCATION"),
      position: LatLng(position.latitude,position.longitude),
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );

    setState(() {
      cameraPosition =  CameraPosition(
        target: LatLng(position.latitude,position.longitude),
        zoom: 15
      );
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
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    _createPolylines( widget.trip.startPosition,  widget.trip.endPosition);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            TopBarModule(
              title: "Passengers Locations", 
              buttonClick: (){
                Navigator.pop(context);
              }, 
              iconData: Icons.arrow_back
            ),
            Expanded(
              child:Container(
                child:cameraPosition != null? GoogleMap(
                  polylines: Set<Polyline>.of(polylines.values),
                  initialCameraPosition: cameraPosition,
                  onMapCreated: _onMapCreated,
                  mapToolbarEnabled: true,
                  // onCameraMoveStarted: cameraMove(),
                  markers: Set<Marker>.of(markers.values),
                  onTap: (latLng){
                    // _addMark(latLng);
                  },
                ):Container(),
              ) 
            )
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      // controller.setMapStyle(_mapStyle);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  @override
  click(bool option) {
    // TODO: implement click
    throw UnimplementedError();
  }
}