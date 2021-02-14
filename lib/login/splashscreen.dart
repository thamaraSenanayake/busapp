import 'package:flutter/material.dart';
import 'package:quickbussl/const.dart';
import 'package:quickbussl/module/customButton.dart';

class SplashScreen extends StatefulWidget {
  final Function(LoginPageList) goToPage;
  SplashScreen({Key key,@required this.goToPage}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _width =0.0;
  double _height =0.0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;
    });
    return SafeArea(
      child: (
        Container(
          width :_width,
          height :_height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25)),
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 12.0,
                      spreadRadius: 3.0,
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                    )
                  ],
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new AssetImage(
                      "assets/logo.jpeg",
                    ),
                  ),
                ),
              ),
              Column(
                children: [

                  CustomButton(
                    text: "Passenger", 
                    buttonClick: (){
                      widget.goToPage(LoginPageList.CusLogin);
                    }
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  CustomButton(
                    text: "Bus Owner", 
                    buttonClick: (){
                      widget.goToPage(LoginPageList.BusLogin);
                    }
                  ),

                  
                ],
              )


          
            ],
          )
          //child: child,
        )
      ),
    );
  }
}