import 'package:flutter/material.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/customButton.dart';
import 'package:quickbussl/module/topBar.dart';
import 'package:quickbussl/module/textbox.dart';
import '../const.dart';

class EditUserDetails extends StatefulWidget {
  final User user;
  EditUserDetails({Key key,@required this.user}) : super(key: key);

  @override
  _EditUserDetailsState createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
  double _width =0.0;
  User _user;
  String _nameError= "";
  String _phoneError= "";
  String _idNumberError= "";
  
  @override
  void initState() { 
    super.initState();
    _user = widget.user;
  }

  _done(){
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
      Database().updateUser(_user);
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
              title: "Update Details", 
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
                    )
                  ],
                ),
              ),
            ),
            TextBox(
              initText: _user.name,
              textBoxKey: null, 
              shadowDisplay: false,
              onChange: (val){
                _user.name = val;
                setState(() {
                  _nameError = "";
                });
              }, 
              textInputType:TextInputType.emailAddress,
              firstLetterCapital: false,
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
              initText: _user.phone,
              textBoxKey: null, 
              shadowDisplay: false,
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
              initText: _user.idNum,
              textBoxKey: null, 
              shadowDisplay: false,
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