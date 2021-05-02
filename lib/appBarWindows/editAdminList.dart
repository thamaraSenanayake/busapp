import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickbussl/database/database.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/topBar.dart';
import 'package:quickbussl/module/textbox.dart';
import 'package:quickbussl/module/userView.dart';
import '../const.dart';

class EditAdminList extends StatefulWidget {
  final User user;
  EditAdminList({Key key, this.user,}) : super(key: key);

  @override
  _EditAdminListState createState() => _EditAdminListState();
}

class _EditAdminListState extends State<EditAdminList> implements UserViewListener {
  double _width =0.0;
  List<User> _user = [];
  List<Widget> _widgetList = [];
  bool _loading = true;
  List<User> _userList = [];
  
  @override
  void initState() { 
    super.initState();
    _loadData();
  }

  _searchList(val){
    List<User> searchList =  _userList.where((item) => item.name.toLowerCase().contains(val.toLowerCase())).toList();
    _buildList(searchList);
  }

  _loadData() async {
    _userList = await Database().getUserList(widget.user.email);
    _buildList(_userList);
  }

  _buildList(List<User> list){
    List<Widget> _widgetListTemp = [];
    for (var item in list) {
      if(item.name == null){
        continue;
      }
      _widgetListTemp.add(
        UserView(user: item, listener: this)
      );
    } 
    setState(() {
      _widgetList = _widgetListTemp;
      _loading = false;
    });

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
              title: "Change Admin", 
              buttonClick: (){
                Navigator.pop(context);
              }, 
              iconData: Icons.arrow_back
            ),

            TextBox(
              textBoxKey: null, 
              shadowDisplay: false,
              textBoxHint: "Search",
              onChange: (val){
                _searchList(val);
              }, 
              textInputType:TextInputType.emailAddress,
              firstLetterCapital: false,
              errorText: "",
              suffixIcon: Icons.search,
            ),

            _loading? Expanded(
              child: Container(
                color: Color.fromRGBO(128, 128, 128, 0.3),
                child: SpinKitDoubleBounce(
                  color: AppData.primaryColor2,
                  size: 50.0,
                ),
              ),
            ):

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Container(
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    children: _widgetList,
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  @override
  changedUser(User user, bool isAdmin) {
    Database().adminEdit(user.email, isAdmin);
  }
}