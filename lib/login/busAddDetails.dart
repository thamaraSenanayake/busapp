import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickbussl/busowner/profileBase.dart';
import 'package:quickbussl/cusProfile/profileBase.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/login/CusLogin.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/module/textbox.dart';
import '../const.dart';

class BusDetailsAdd extends StatefulWidget {
  final Function(LoginPageList) goToPage;
  BusDetailsAdd({Key key, this.goToPage}) : super(key: key);

  @override
  _BusDetailsAddState createState() => _BusDetailsAddState();
}

class _BusDetailsAddState extends State<BusDetailsAdd> {
  double _width =0.0;
  double _height =0.0;
  
  User _user = User();
  bool _loading = false;
  

  String _nameError= "";
  String _phoneError= "";
  String _idNumberError= "";

  _signIn(){
    FocusScope.of(context).unfocus();

    bool _validation = true;
    if(_user.name != null && _user.name.isEmpty){
      setState(() {
        _nameError = "Required field";
        _validation = false;
      });
    }
    if(_user.phone != null && _user.phone.isEmpty){
      setState(() {
        _phoneError = "Required field";
        _validation = false;
      });
    }
    if(_user.idNum != null && _user.idNum.isEmpty){
      setState(() {
        _idNumberError = "Required field";
        _validation = false;
      });
    }

    if(_validation){
      _user.userType = UserType.Passenger;
      setState(() {
        _loading = true;
      });
      Database().updateUser(_user);
      final storage = new FlutterSecureStorage();
      storage.write(key: KeyContainer.USERNAME,value: _user.email);
      storage.write(key: KeyContainer.PASSWORD,value: _user.password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BusOwnerProfile(
            user: _user,
          )
        )
      );
      setState(() {
        _loading = false;
      });
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
                                  
                                ],
                              ),
                            ),
                          ),
                          TextBox(
                            textBoxKey: null, 
                            enable: false,
                            onChange: (val){
                              
                            }, 
                            textInputType:TextInputType.emailAddress,
                            errorText: ""
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
                              _user.name = val;
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
                              _user.phone = val;
                              setState(() {
                                _phoneError = "";
                              });
                            }, 
                            errorText: _phoneError,
                          textInputType:TextInputType.phone,

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
                                    _idNumberError,
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
                              _user.idNum = val;
                              setState(() {
                                _idNumberError = "";
                              });
                            }, 
                            errorText: _idNumberError,
                            // textInputType:TextInputType.text,

                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      text: "Done", 
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