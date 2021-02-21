import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../const.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime initDate; 
  final String title;
  final Function(DateTime) onChange;
  CustomDatePicker({Key key,@required this.initDate,@required this.onChange,@required this.title}) : super(key: key);

  @override
  _CustomDatePicker createState() => _CustomDatePicker();
}

class _CustomDatePicker extends State<CustomDatePicker> {
  DateTime _initDate;
  double _width = 0.0;

  _getDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _initDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _initDate){
      setState(() {
        _initDate = picked;
      });
      widget.onChange(_initDate);
    }
  }

  @override
  void initState() { 
    super.initState();
    _initDate = widget.initDate;
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
        _getDate();
      },
      child: Container(
        width: _width - 40,
        constraints: BoxConstraints(
          minHeight: 50
        ),
        padding:EdgeInsets.only(
          left:20,
          right:20,
        ),
        decoration: BoxDecoration(
          // color: widget.errorText.length ==0 ?Colors.white:Colors.redAccent,
          color: AppData.whiteColor,
          border: Border.all(
            color: AppData.primaryColor2,
            width: 1
          ),
          borderRadius: BorderRadius.circular(3),
          // boxShadow: [
          //   BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25)),
          //   BoxShadow(
          //     color: Color.fromRGBO(0, 0, 0, 0.25),
          //     blurRadius: 12.0,
          //     spreadRadius: 3.0,
          //     offset: Offset(
          //       1.0,
          //       1.0,
          //     ),
          //   )
          // ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: AppData.blackColor
              ),
            ),
            Text(
              DateFormat.yMEd().format(_initDate),
              style: TextStyle(
                color: AppData.blackColor
              ),
            ),
            Icon(
              Icons.date_range,
              color: AppData.primaryColor2
            )
            
          ],
        ),
      ),
    );
  }
}