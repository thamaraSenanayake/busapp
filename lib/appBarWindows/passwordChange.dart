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
  String _currentPassword= "";
  String _newPassword= "";
  String _confirmPassword= "";
  
  @override
  void initState() { 
    super.initState();
    _user = widget.user;
  }

  _done(){
    FocusScope.of(context).unfocus();

    bool _validation = true;
    
    if(_user.password != _currentPassword){
      setState(() {
        _currentPasswordError = "Current password is invalid";
        _validation = false;
      });
    }
    else if(_newPassword != _confirmPassword){
      setState(() {
        _confirmPasswordError = "Password not matching";
        _validation = false;
      });
    }
    

    if(_validation){
      _user.password = _newPassword;
      final storage = new FlutterSecureStorage();
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
                _user.phone = val;
                setState(() {
                  _newPasswordError = "";
                });
              }, 
              errorText: _newPasswordError,
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
                _confirmPasswordError = val;
                setState(() {
                  _confirmPasswordError = "";
                });
              }, 
              errorText: _confirmPasswordError,
              // textInputType:TextInputType.text,

            ),

            SizedBox(
              height: 50,
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