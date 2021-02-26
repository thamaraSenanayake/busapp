import 'package:flutter/painting.dart';

enum LoginPageList{
  SplashScreen,
  CusLogin,
  CusSignin,
  AdminLogin,
  BusLogin,
  BusAddDetails
}

class AppData{
  static Color primaryColor= Color(0xffD64545);
  static Color primaryColor1= Color(0xffee4040);
  static Color primaryColor2= Color(0xfff17171);
  static Color whiteColor= Color(0xFFFFFBFB);
  static Color blackColor= Color(0xff393939);
  static Color greenColor = Color(0xff70b545);
}

class KeyContainer {
  static const String USERNAME = 'username';
  static const String PASSWORD = 'password';
}