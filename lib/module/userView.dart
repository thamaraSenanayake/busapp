import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickbussl/model/user.dart';

import '../const.dart';

class UserView extends StatefulWidget {
  final User user;
  final UserViewListener listener;
  UserView({Key key,@required this.user,@required this.listener}) : super(key: key);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  double _width = 0;
  bool _isAdmin = false;
  

  @override
  void initState() { 
    super.initState();
    if(widget.user.userType == UserType.Admin){
      _isAdmin = true;
    }
  }


  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:10),
        width: _width - 20,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.white,
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

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.user.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Switch(
                  value: _isAdmin, 
                  onChanged: (val){
                    setState(() {
                      _isAdmin = !_isAdmin;
                    });
                    widget.listener.changedUser(widget.user, _isAdmin);
                  },
                  activeTrackColor: AppData.primaryColor2,
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                )
              ],
            ),
            Text(
              widget.user.email,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.grey
              ),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class UserViewListener{
  changedUser(User user,bool isAdmin);
}