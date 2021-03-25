import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/module/topBar.dart';
import 'package:quickbussl/module/textbox.dart';
import '../const.dart';

class UpdatePassword extends StatefulWidget {
  final User user;
  UpdatePassword({Key key,@required this.user}) : super(key: key);

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  double _width =0.0;
  User _user;
  String _currentPasswordError= "";
  String _newPasswordError= "";
  String _confirmPasswordError= "";
  String _regexValidationError= "";
  String _currentPassword= "";
  String _newPassword= "";
  String _confirmPassword= "";
  
  @override
  void initState() { 
    super.initState();
    _user = widget.user;
  }

  _done() async {
    FocusScope.of(context).unfocus();
     RegExp _regExp = RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$",
      caseSensitive: false,
      multiLine: false,
    );
    bool _validation = true;
    final storage = new FlutterSecureStorage();
    String _password = await storage.read(key: KeyContainer.PASSWORD);
    
    if(_password != _currentPassword){
      setState(() {
        _currentPasswordError = "invalid password";
        _validation = false;
      });
    }
    else if(_newPassword != _confirmPassword){
      setState(() {
        _confirmPasswordError = "Password not matching";
        _validation = false;
      });
    }else if (!_regExp.hasMatch(_newPassword)){
      setState(() {
        _regexValidationError = "Password must contain Minimum eight characters and at least one letter and one number";
        _validation = false;
      });
    }
    

    if(_validation){
      _user.password = _newPassword;
      storage.write(key: KeyContainer.PASSWORD,value: _user.password);
      Database().changePassword(_user);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBarModule(
              title: "Change Password", 
              buttonClick: (){
                Navigator.pop(context);
              }, 
              iconData: Icons.arrow_back
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 5),
              child: Container(
                width: _width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Current Password: ",
                      style: TextStyle(
                        color: AppData.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        backgroundColor: Colors.white
                      ),
                    ),
                    Text(
                      _currentPasswordError,
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
              obscureText: true,
              textBoxKey: null, 
              shadowDisplay: false,
              onChange: (val){
                _currentPassword = val;
                setState(() {
                  _currentPasswordError = "";
                });
              }, 
              textInputType:TextInputType.emailAddress,
              firstLetterCapital: false,
              errorText: _currentPasswordError
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 5),
              child: Container(
                width: _width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New password: ",
                      style: TextStyle(
                        color: AppData.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        backgroundColor: Colors.white
                      ),
                    ),
                    Text(
                      _newPasswordError,
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
              obscureText: true,
              textBoxKey: null, 
              shadowDisplay: false,
              onChange: (val){
                _newPassword= val;
                setState(() {
                  _newPasswordError = "";
                });
              }, 
              errorText: _newPasswordError,
            // textInputType:TextInputType.phone,

            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 5),
              child: Container(
                width: _width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Confirm password: ",
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
              obscureText: true,
              textBoxKey: null, 
              shadowDisplay: false,
              onChange: (val){
                _confirmPassword = val;
                setState(() {
                  _confirmPasswordError = "";
                });
              }, 
              errorText: _confirmPasswordError,
            ),

            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
              child: Text(
                _regexValidationError,
                style: TextStyle(
                  color: AppData.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.white
                ),
              ),
            ),

            CustomButton(
              text: "Done", 
              buttonClick: (){
                _done();
              }
            )
          ],
        ),
      ),
    );
  }
}