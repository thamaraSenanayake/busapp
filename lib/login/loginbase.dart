import 'package:flutter/material.dart';
import 'package:quickbussl/const.dart';
import 'package:quickbussl/login/AdminLogin.dart';
import 'package:quickbussl/login/BusLogin.dart';
import 'package:quickbussl/login/CusLogin.dart';
import 'package:quickbussl/login/CusSignin.dart';
import 'package:quickbussl/login/splashscreen.dart';

class LoginBase extends StatefulWidget {
  LoginBase({Key key}) : super(key: key);

  @override
  _LoginBaseState createState() => _LoginBaseState();
}

class _LoginBaseState extends State<LoginBase> {
  LoginPageList _currentPage = LoginPageList.SplashScreen;
  double _width =0.0;
  double _height =0.0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;
    });
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body:Container(
          child: Stack(
            children: [
              Container(
                height: _height,
                width: _width,
                child: 
                _currentPage == LoginPageList.SplashScreen?
                SplashScreen(goToPage: (val) {
                    setState(() {
                      _currentPage = val;
                    });
                  },
                ):

                _currentPage == LoginPageList.CusLogin?
                CusLogin(
                  goToPage: (val) {
                    setState(() {
                      _currentPage = val;
                    });
                  },
                ):

                _currentPage == LoginPageList.CusSignin?
                CusSigning(
                  goToPage: (val) {
                    setState(() {
                      _currentPage = val;
                    });
                  },
                ):

                _currentPage == LoginPageList.AdminLogin?
                AdminLogin():

                
                BusLogin()
              ),

            ]
          ),
        )
      );
  }
}
