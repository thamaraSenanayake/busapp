import 'package:flutter/material.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/module/topBar.dart';
import 'package:quickbussl/module/textbox.dart';
import '../const.dart';

class AddBusOwner extends StatefulWidget {
  AddBusOwner({Key key,}) : super(key: key);

  @override
  _AddBusOwnerState createState() => _AddBusOwnerState();
}

class _AddBusOwnerState extends State<AddBusOwner> {
  double _width =0.0;
  User _user = User();
  String _emailError= "";
  String _passwordError= "";
  
  @override
  void initState() { 
    super.initState();
  }

  _done(){
    FocusScope.of(context).unfocus();

    bool _validation = true;
    
    if(_user.email != null && _user.email.isEmpty){
      setState(() {
        _emailError = "Required field";
        _validation = false;
      });
    }
    if(_user.password != null && _user.password.isEmpty){
      setState(() {
        _passwordError = "Required field";
        _validation = false;
      });
    }
    

    if(_validation){
      Database().addBusOwnerUser(_user);
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
              title: "Add Bus owner", 
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
              shadowDisplay: false,
              onChange: (val){
                _user.email = val;
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
                    ),

                    
                  ],
                ),
              ),
            ),
            TextBox(
              textBoxKey: null, 
              shadowDisplay: false,
              onChange: (val){
                _user.password = val;
                setState(() {
                  _passwordError = "";
                });
              }, 
              textInputType:TextInputType.text,
              firstLetterCapital: false,
              errorText: _passwordError
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