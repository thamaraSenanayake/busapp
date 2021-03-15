import 'package:flutter/material.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/seat.dart';
import 'package:quickbussl/model/user.dart';

import '../../const.dart';

class MapInfoView extends StatefulWidget {
  final Seat seat;
  MapInfoView({Key key,@required this.seat}) : super(key: key);

  @override
  _MapInfoViewState createState() => _MapInfoViewState();
}

class _MapInfoViewState extends State<MapInfoView> {
  double _width = 0;
  String _userName='';
  String _telNumber='';

  _getUserInfo() async {
    User user = await Database().getUser(widget.seat.email);
    setState(() {
      _userName=user.name;
      _telNumber=user.phone;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Container(
      height: 150,
      width: _width-40,
      decoration: BoxDecoration(
        color: AppData.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25)),
          BoxShadow(
            color:Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 12.0,
            spreadRadius: 3.0,
            offset: Offset(
              1.0,
              1.0,
            ),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 150,
            width: 100,
            child: Image.asset(
              'assets/user.png'
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 150,
              width: _width-160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text:TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Name : ',
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppData.blackColor
                              
                            )
                          ),
                          TextSpan(
                            text: _userName,
                            style:TextStyle(
                              fontSize: 15,
                              color: AppData.blackColor
                            ),
                            
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text:TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tel : ',
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppData.blackColor
                              
                            )
                          ),
                          TextSpan(
                            text: _telNumber,
                            style:TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                              decoration: TextDecoration.underline
                            ),
                            
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text:TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Seat Number : ',
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppData.blackColor
                              
                            )
                          ),
                          TextSpan(
                            text: widget.seat.number.toString(),
                            style:TextStyle(
                              fontSize: 15,
                              color: AppData.blackColor
                            ),
                            
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text:TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Get In : ',
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppData.blackColor
                              
                            )
                          ),
                          TextSpan(
                            text: widget.seat.getInPlace,
                            style:TextStyle(
                              fontSize: 15,
                              color: AppData.blackColor
                            ),
                            
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text:TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Get off : ',
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppData.blackColor
                            )
                          ),
                          TextSpan(
                            text: widget.seat.getOutPlace,
                            style:TextStyle(
                              fontSize: 15,
                              color: AppData.blackColor
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}