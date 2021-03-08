import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickbussl/busowner/profileBase.dart';
import 'package:quickbussl/const.dart';
import 'package:quickbussl/cusProfile/profileBase.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/user.dart';
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
  bool _checking = true;

  _autoLogin() async {
    final storage = new FlutterSecureStorage();
    String username = await storage.read(key: KeyContainer.USERNAME);
    String password = await storage.read(key: KeyContainer.PASSWORD);
    
    if(username != null && password != null){
      User user =await Database().login(username, password);

      if(user != null){
        if(user.userType == UserType.Passenger){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CusProfile(
                user: user,
              )
            )
          );
        }else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BusOwnerProfile(
                user: user,
              )
            )
          );
        }
      }
    }
    setState(() {
      _checking = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _autoLogin();
  }
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;
    });
    return Container(
      width :_width,
      height :_height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width :_width,
              height :_height,
              decoration: new BoxDecoration(
                color:  AppData.blackColor,
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  alignment:Alignment.topCenter,
                  colorFilter: new ColorFilter.mode(AppData.whiteColor.withOpacity(0.7), BlendMode.softLight),
                  image: new AssetImage(
                    "assets/background.jpg",
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
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
                    !_checking? Column(
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
                    ):Container(
                      // color: Color.fromRGBO(128, 128, 128, 0.3),
                      child: SpinKitDoubleBounce(
                        color: AppData.primaryColor,
                        size: 50.0,
                      ),
                    )


                
                  ],
                )
                //child: child,
              )
            ),
          ),
        ],
      ),
    );
  }
}