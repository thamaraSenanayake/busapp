import 'package:flutter/material.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/module/textbox.dart';

import '../const.dart';

class BusLogin extends StatefulWidget {
  final Function(LoginPageList) goToPage;
  BusLogin({Key key, this.goToPage}) : super(key: key);

  @override
  _BusLoginState createState() => _BusLoginState();
}

class _BusLoginState extends State<BusLogin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double _width =0.0;
  double _height =0.0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;
    });
    return Container(
      width :_width,
      height :_height,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: _width,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal:20),
                  // color: Colors.black,
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: (){
                            widget.goToPage(LoginPageList.SplashScreen);
                          },
                          child: Container(
                            child: Icon(
                              Icons.arrow_back,
                              size: 35,
                              color: AppData.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: AppData.primaryColor,
                            fontSize: 35,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                      Container()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0,bottom: 5),
                  child: Container(
                    width: _width - 40,
                    child: Row(
                      children: [
                        Text(
                          "Email: ",
                          style: TextStyle(
                            color: AppData.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextBox(
                  textBoxKey: null, 
                  onChange: (val){

                  }, 
                  errorText: ""
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0,bottom: 5),
                  child: Container(
                    width: _width - 40,
                    child: Row(
                      children: [
                        Text(
                          "Password: ",
                          style: TextStyle(
                            color: AppData.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextBox(
                  textBoxKey: null, 
                  onChange: (val){

                  }, 
                  errorText: ""
                ),


              ],
            ),
            CustomButton(
              text: "Login", 
              buttonClick: (){
                // widget.goToPage(LoginPageList.BusLogin);
              }
            )
          ],
        ),
      ),
    );
  }
}