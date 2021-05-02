import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickbussl/cusProfile/profileBase.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/module/textbox.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../const.dart';

class CusLogin extends StatefulWidget {
  final Function(LoginPageList) goToPage;
  CusLogin({Key key, this.goToPage}) : super(key: key);

  @override
  _CusLoginState createState() => _CusLoginState();
}

class _CusLoginState extends State<CusLogin> {
  String _email = '';
  String _password = '';
  String _emailError = '';
  String _passwordError = '';
  String _loginError = '';
  double _width =0.0;
  double _height =0.0;
  bool _loading = false;
  bool _keyBoardVisibility = false;


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
      if(user != null && (user.userType == UserType.Passenger || user.userType == UserType.Admin)){
        final storage = new FlutterSecureStorage();
        storage.write(key: KeyContainer.USERNAME,value: _email);
        storage.write(key: KeyContainer.PASSWORD,value: _password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CusProfile(
              user: user,
            )
          )
        );
      }else{
        setState(() {
          _loginError = "Invalid user details";
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    KeyboardVisibility.onChange.listen((bool visible) {
      if(mounted){
        setState(() {
          _keyBoardVisibility = visible;
        });
      } 
    });
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
          Container(
            width :_width,
            height :_height,
            child: SafeArea(
              child: Stack(
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
                    padding: const EdgeInsets.only(top:50.0,left:0,right:0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:10.0,bottom: 5,left: 20),
                              child: Container(
                                width: _width,
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
                              onChange: (val){
                                _email = val;
                              setState(() {
                                  _emailError = "";
                                });
                              }, 
                              textInputType:TextInputType.emailAddress,
                              firstLetterCapital: false,
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
                              onChange: (val){
                                _password = val;
                              setState(() {
                                  _passwordError = "";
                                });
                              }, 
                              obscureText: true,
                              errorText: _passwordError
                            ),

                            Container(
                              width: _width-40,
                              child: Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: Text(
                                  _loginError,
                                  style: TextStyle(
                                    color: AppData.primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            
                          ],
                        ),
                        Column(
                          children: [
                            CustomButton(
                              text: "Login", 
                              buttonClick: (){
                                _login();
                              }
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              text: "Sing In", 
                              buttonClick: (){
                                widget.goToPage(LoginPageList.CusSignin);
                              }
                            ),
                            SizedBox(
                              height: 10,
                            ),

                          ],
                        )
                        // SizedBox(
                        //   height:_keyBoardVisibility?50: _height-_height/1.8,
                        // ),

                      ],
                    ),
                  ),

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