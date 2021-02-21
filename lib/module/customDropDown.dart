import 'package:flutter/material.dart';

import '../const.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> list; 
  final String selectedText;
  final Function(String) onChange;
  CustomDropDown({Key key,@required this.list,@required this.onChange,@required this.selectedText}) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String _selectedText;
  double _width = 0.0;

  @override
  void initState() { 
    super.initState();
    _selectedText = widget.selectedText;
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Container(
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
      child: DropdownButtonHideUnderline(
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppData.whiteColor,
            iconTheme: IconThemeData(color:AppData.primaryColor2)
          ),
          child: DropdownButton<String>(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color:AppData.primaryColor2
            ),
            value: _selectedText,
            onChanged: (String newValue) {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                _selectedText = newValue;
              });
              widget.onChange(_selectedText);
            },
            items: widget.list
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  width: (_width - 20)-90-32,
                  child: Text(
                    value,
                    overflow:TextOverflow.fade,
                    style: TextStyle(
                      color: AppData.blackColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}