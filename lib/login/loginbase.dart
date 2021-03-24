import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quickbussl/const.dart';
import 'package:quickbussl/login/AdminLogin.dart';
import 'package:quickbussl/login/BusLogin.dart';
import 'package:quickbussl/login/CusLogin.dart';
import 'package:quickbussl/login/CusSignin.dart';
import 'package:quickbussl/login/splashscreen.dart';
import 'package:quickbussl/model/user.dart';

import 'busAddDetails.dart';

class LoginBase extends StatefulWidget {
  LoginBase({Key key}) : super(key: key);

  @override
  _LoginBaseState createState() => _LoginBaseState();
}

class _LoginBaseState extends State<LoginBase> {
  LoginPageList _currentPage = LoginPageList.SplashScreen;
  double _width =0.0;
  double _height =0.0;
  User _user;

  _initLocalNotification() async {

    const AndroidInitializationSettings initializationSettingsAndroid =AndroidInitializationSettings('@mipmap/ic_launcher');
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
    final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
        requestBadgePermission: false,
        requestSoundPermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification,
      );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: selectNotification);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: selectNotification);

    if(Platform.isIOS){
      final bool result = await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    }
  }
  
   Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
      // display a dialog with the notification details, tap ok to go to another page
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                // Navigator.of(context, rootNavigator: true).pop();
                // await Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SecondScreen(payload),
                //   ),
                // );
              },
            )
          ],
        ),
      );
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    }
  }

  @override
  void initState() {
    super.initState();
    _initLocalNotification();
    
  }
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

                _currentPage == LoginPageList.BusLogin?
                BusLogin(
                  goToPage: (val,user) {
                    if(user!= null){
                      _user = user;
                    }
                    setState(() {
                      _currentPage = val;
                    });
                  },
                ):
                _currentPage == LoginPageList.BusAddDetails?
                BusDetailsAdd(
                  goToPage: (val) {
                    setState(() {
                      _currentPage = val;
                    });
                  },
                  user: _user,
                ):Container()
              ),

            ]
          ),
        )
      );
  }
}
