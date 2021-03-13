import 'package:flutter/material.dart';

import '../const.dart';

class LocationError extends StatefulWidget {
  final LocationErrorListener listener;
  
  LocationError({Key key, this.listener}) : super(key: key);

  @override
  _LocationErrorState createState() => _LocationErrorState();
}

class _LocationErrorState extends State<LocationError> {
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      content: Container(
        width: 260.0,
        height: 150.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            
            // dialog centre
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom:5.0),
                  child: Text(
                    "Error !",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Error In accessing your location try to turn on the device location and try again',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment:  MainAxisAlignment.end,
              children: <Widget>[
                // dialog button
                Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: GestureDetector(
                    onTap: () {
                      widget.listener.click(true);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Try agin',
                        style: TextStyle(
                          color: AppData.primaryColor1,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

              ]
            ),
          ],
        ),
      ),
    );
  }
}




abstract class LocationErrorListener{
  click(bool option);
}