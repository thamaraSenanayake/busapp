import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../const.dart';

class GetLocation extends StatefulWidget {
  final Function(String,LatLng) setLocation;
  GetLocation({Key key,@required this.setLocation}) : super(key: key);

  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  String _location ="";
  LatLng _position;

   Future<void> _handlePressButton() async {
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

    displayPrediction(p);
  }

   void onError(PlacesAutocompleteResponse response) {
    print(response.errorMessage);
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: AppData.kGoogleApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;
      setState(() {
        _position = LatLng(lat, lng);
        _location = detail.result.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _handlePressButton();
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 50,
        padding:EdgeInsets.only(
          left: 20,
          right: 20,
          top: 15
        ),
        decoration: BoxDecoration(
          color: AppData.whiteColor,
          border: Border.all(
            color: AppData.primaryColor2,
            width: 1
          ),
        ),
        child: Text(
          _location,
          style:TextStyle(
            color: AppData.blackColor, 
            fontSize:15,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}