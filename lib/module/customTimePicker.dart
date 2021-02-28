import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../const.dart';

class CustomTimePicker extends StatefulWidget {
  final TimeOfDay initTime; 
  final String title;
  final Function(TimeOfDay) onChange;
  CustomTimePicker({Key key,@required this.initTime,@required this.onChange,@required this.title}) : super(key: key);

  @override
  _CustomTimePicker createState() => _CustomTimePicker();
}

class _CustomTimePicker extends State<CustomTimePicker> {
  double _width = 0.0;
  TimeOfDay _selectedTime;

  Future<Null> _selectTime(BuildContext context) async {
  final TimeOfDay picked = await showTimePicker(
    context: context,
    initialTime: _selectedTime,
  );
  if (picked != null)
    setState(() {
      _selectedTime = picked;
    });}

  @override
  void initState() { 
    super.initState();
    _selectedTime = widget.initTime;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
        _selectTime(context);
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
              _selectedTime.format(context),
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