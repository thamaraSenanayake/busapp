import 'package:flutter/material.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/module/textbox.dart';
import '../const.dart';

class CusSigning extends StatefulWidget {
  final Function(LoginPageList) goToPage;
  CusSigning({Key key, this.goToPage}) : super(key: key);

  @override
  _CusSigningState createState() => _CusSigningState();
}

class _CusSigningState extends State<CusSigning> {
  double _width =0.0;
  double _height =0.0;
  
  String _email= "";
  String _name= "";
  String _phone= "";
  String _idNumbe= "";
  String _password= "";
  String _confirmPassword= "";

  String _emailError= "";
  String _nameError= "";
  String _phoneError= "";
  String _idNumbeError= "";
  String _passwordError= "";
  String _confirmPasswordError= "";

  _signIn(){
    bool _validation = true;
    if(_email.isEmpty){
      setState(() {
        _emailError = "Required field";
        _validation = false;
      });
    }
    if(_name.isEmpty){
      setState(() {
        _nameError = "Required field";
        _validation = false;
      });
    }
    if(_phone.isEmpty){
      setState(() {
        _phoneError = "Required field";
        _validation = false;
      });
    }
    if(_idNumbe.isEmpty){
      setState(() {
        _idNumbeError = "Required field";
        _validation = false;
      });
    }
    if(_password.isEmpty){
      setState(() {
        _passwordError = "Required field";
        _validation = false;
      });
    }
    if(_confirmPassword.isEmpty){
      setState(() {
        _confirmPasswordError = "Required field";
        _validation = false;
      });
    }

    if(_validation){
      //todo
    }
  }


  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;
    });
    return
      Container(
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
            child: Padding(
              padding: const EdgeInsets.only(top:50.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: _width,
                      child: Column(
                        children: [
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
                                  ),
                                  
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
                                    "Name: ",
                                    style: TextStyle(
                                      color: AppData.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      backgroundColor: Colors.white
                                    ),
                                  ),
                                  Text(
                                    _nameError,
                                    style: TextStyle(
                                      color: AppData.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.white
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                          TextBox(
                            textBoxKey: null, 
                            onChange: (val){
                              _name = val;
                              setState(() {
                                _nameError = "";
                              });
                            }, 
                            errorText: _nameError
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:10.0,bottom: 5),
                            child: Container(
                              width: _width - 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Phone: ",
                                    style: TextStyle(
                                      color: AppData.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      backgroundColor: Colors.white
                                    ),
                                  ),
                                  Text(
                                    _phoneError,
                                    style: TextStyle(
                                      color: AppData.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.white
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                          TextBox(
                            textBoxKey: null, 
                            onChange: (val){
                              _phone = val;
                              setState(() {
                                _phoneError = "";
                              });
                            }, 
                            errorText: _phoneError
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:10.0,bottom: 5),
                            child: Container(
                              width: _width - 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Id number: ",
                                    style: TextStyle(
                                      color: AppData.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      backgroundColor: Colors.white
                                    ),
                                  ),
                                  Text(
                                    _idNumbeError,
                                    style: TextStyle(
                                      color: AppData.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.white
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                          TextBox(
                            textBoxKey: null, 
                            onChange: (val){
                              _idNumbe = val;
                              setState(() {
                                _idNumbeError = "";
                              });;
                            }, 
                            errorText: _idNumbeError
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
                                  ),
                                  
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
                            errorText: _passwordError
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:10.0,bottom: 5),
                            child: Container(
                              width: _width - 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Confirm Password: ",
                                    style: TextStyle(
                                      color: AppData.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      backgroundColor: Colors.white
                                    ),
                                  ),
                                  Text(
                                    _confirmPasswordError,
                                    style: TextStyle(
                                      color: AppData.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.white
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                          TextBox(
                            textBoxKey: null, 
                            onChange: (val){
                              _confirmPassword = val;
                              setState(() {
                                _confirmPasswordError = "";
                              });
                            }, 
                            errorText: _confirmPasswordError
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      text: "Sign In", 
                      buttonClick: (){
                        _signIn();
                      }
                    )
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
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
                        widget.goToPage(LoginPageList.CusLogin);
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
                      "Sign In",
                      style: TextStyle(
                        color: AppData.primaryColor,
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        // backgroundColor: Colors.white
                      ),
                    ),
                  ),
                  Container()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}