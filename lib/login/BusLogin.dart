import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickbussl/busowner/profileBase.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/module/textbox.dart';

import '../const.dart';

class BusLogin extends StatefulWidget {
  final Function(LoginPageList , User) goToPage;
  BusLogin({Key key,@required this.goToPage}) : super(key: key);

  @override
  _BusLoginState createState() => _BusLoginState();
}

class _BusLoginState extends State<BusLogin> {
  String _email = '';
  String _password = '';
  String _emailError = '';
  String _passwordError = '';
  String _loginError = '';
  double _width =0.0;
  double _height =0.0;
  bool _loading = false;

  _login() async {
    FocusScope.of(context).unfocus();
    bool _validation = true;
    if(_email.isEmpty){
      setState(() {
        _emailError = "Required Field";
      });
      _validation = false;
    }
    if(_password.isEmpty){
      setState(() {
        _passwordError = "Required Field";
      });
      _validation = false;
    }

    if(_validation){
      setState(() {
        _loginError = "";
      });
      User user = await Database().login(_email, _password);
      if(user != null && user.userType == UserType.BusOwner){
        if(user.name.isNotEmpty && user.name != null){
          final storage = new FlutterSecureStorage();
          storage.write(key: KeyContainer.USERNAME,value: _email);
          storage.write(key: KeyContainer.PASSWORD,value: _password);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BusOwnerProfile(
                user: user,
              )
            )
          );
        }else{
          widget.goToPage(LoginPageList.BusAddDetails,user);
        }
      }else{
        setState(() {
          _loginError = "Invalid user details";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;
    });
    return Container(
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
          Container(
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
                                  widget.goToPage(LoginPageList.SplashScreen,null);
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Email: ",
                                style: TextStyle(
                                  color: AppData.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  backgroundColor: Colors.white
                                ),
                              ),
                              Text(
                                _emailError,
                                style: TextStyle(
                                  color: AppData.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.white
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      TextBox(
                        textBoxKey: null, 
                        textInputType:TextInputType.emailAddress,
                        firstLetterCapital: false,
                        onChange: (val){
                          _email = val;
                          setState(() {
                            _emailError ="";
                          });
                        }, 
                        errorText: _emailError
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10.0,bottom: 5),
                        child: Container(
                          width: _width - 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Password: ",
                                style: TextStyle(
                                  color: AppData.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  backgroundColor: Colors.white
                                ),
                              ),
                              Text(
                                _passwordError,
                                style: TextStyle(
                                  color: AppData.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.white
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      TextBox(
                        textBoxKey: null,
                        obscureText: true, 
                        onChange: (val){
                          _password = val;
                          setState(() {
                            _passwordError = "";
                          });
                        }, 
                        errorText: _passwordError
                      ),


                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        _loginError,
                        style: TextStyle(
                          color: AppData.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.white
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: "Login", 
                        buttonClick: (){
                          _login();
                        }
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          _loading
          ? Container(
            color: Color.fromRGBO(128, 128, 128, 0.3),
            child: SpinKitDoubleBounce(
              color: AppData.primaryColor,
              size: 50.0,
            ),
          )
          : Container(),
        ],
      ),
    );
  }
}