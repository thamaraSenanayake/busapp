import 'package:flutter/material.dart';

import '../const.dart';

class TopBarModule extends StatefulWidget {
  final String title;
  final Function buttonClick;
  final IconData iconData;
  TopBarModule({Key key,@required this.title,@required this.buttonClick,@required this.iconData}) : super(key: key);

  @override
  _TopBarModuleState createState() => _TopBarModuleState();
}

class _TopBarModuleState extends State<TopBarModule> {
  double _width;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Container(
      height: 40,
      width: _width,
      // decoration: BoxDecoration(
      //   color: AppData.primaryColor,
      // ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              widget.buttonClick();
            },
            child: Container(
              height: 70,
              width: 70,
              child: Center(
                child: Icon(
                  widget.iconData,
                  color:AppData.primaryColor,
                  size: 35,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: TextStyle(
                color: AppData.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700
              ),
            ),
          )
        ],
      ),
    );
  }
}