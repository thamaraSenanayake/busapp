import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quickbussl/appBarWindows/aboutUs.dart';
import 'package:quickbussl/appBarWindows/addBusOwner.dart';
import 'package:quickbussl/appBarWindows/editAdminList.dart';
import 'package:quickbussl/appBarWindows/editDetails.dart';
import 'package:quickbussl/appBarWindows/passwordChange.dart';
import 'package:quickbussl/cusProfile/addTicket/addTicket.dart';
import 'package:quickbussl/cusProfile/bookedHistory.dart';
import 'package:quickbussl/cusProfile/bookedTrip.dart';
import 'package:quickbussl/login/loginbase.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';

import '../appBarWindows/privacyPolicy.dart';
import '../const.dart';

class CusProfile extends StatefulWidget {
  final User user;
  CusProfile({Key key,@required this.user}) : super(key: key);

  @override
  _CusProfileState createState() => _CusProfileState();
}

class _CusProfileState extends State<CusProfile> with TickerProviderStateMixin implements ProfileBaseListener {
  double _height  =0.0;
  double _width =0.0;
  String _selectedDeparture = '';
  String _selectedArrive = '';
  DateTime _selectedDate; 
  bool _bottomBarVisibility = true;
  String _title = "Enter Location";
  CusProfilePages _profilePage =CusProfilePages.Add;
  TabController _tabController;
  Trip _trip = Trip();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    KeyboardVisibility.onChange.listen((bool visible) {
      if(mounted){
        setState(() {
          _bottomBarVisibility =! visible;
        });
      } 
    });
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      _height =MediaQuery.of(context).size.height;
      _width =MediaQuery.of(context).size.width;
    });
    return DefaultTabController(
      length: 3,
      child: WillPopScope(
        onWillPop:_onBackPressed,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          //resizeToAvoidBottomPadding: false,
          key: _scaffoldKey,
          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: AppData.primaryColor,
            ),
            child:Drawer(
              child: ListView(
                children: _appDrawerContent(),
              ),
            ),
          ),
          body: Container(
            height:_height,
            width:_width,
            child: Stack(
              children: [
                
                Container(
                  height:_height,
                  width:_width,
                  color: Colors.white,
                ),


               _bottomBarVisibility? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: _width,
                    height: 40,
                    color: AppData.primaryColor,
                  ),
                ):Container(),

                Container(
                  height:_height,
                  width:_width,
                  child:SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child:TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller:_tabController,
                            children: [
                              AddTicketBase(
                                trip: _trip, 
                                user: widget.user,
                                listener: this, 
                                selectedArrive: _selectedArrive, 
                                selectedDate: _selectedDate, 
                                selectedDeparture: _selectedDeparture,
                              ),
                              BookedTrip(trip: _trip,listener: this, user: widget.user,),
                              BookedHistory(trip: _trip,listener: this,user: widget.user),
                            ],
                          )
                        ),
                        _bottomBarVisibility?Container(
                          height: 50,
                          color: AppData.primaryColor,
                          child: TabBar(
                            indicatorColor:Colors.transparent,
                            indicatorSize:TabBarIndicatorSize.tab,
                            onTap: (val){
                              if (val == 0) {
                                _tabController.animateTo(0);
                                
                                if(mounted){
                                  setState(() {
                                    _profilePage = CusProfilePages.Add;
                                  });
                                } 
                              } else if (val == 1) {
                                _tabController.animateTo(1);
                                if(mounted){
                                  setState(() {
                                    _profilePage = CusProfilePages.BookedTrip;
                                  });
                                } 
                              }
                              else if (val == 2) {
                                _tabController.animateTo(2);
                                if(mounted){
                                  setState(() {
                                    _profilePage = CusProfilePages.BookedHistory;
                                  });
                                } 
                              }
                            },
                            tabs: [
                              Tab(
                                child: Container(
                                  height: 80,
                                  width: _width/3,
                                  color:_profilePage != CusProfilePages.Add?AppData.primaryColor:AppData.primaryColor2,
                                  child: Icon(
                                    Icons.add_alert_outlined,
                                    color:AppData.whiteColor,
                                    size: 25,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  height: 80,
                                  width: _width/3,
                                  color:_profilePage != CusProfilePages.BookedTrip?AppData.primaryColor:AppData.primaryColor2,
                                  child: Icon(
                                    Icons.check_circle,
                                    color:AppData.whiteColor,
                                    size: 25,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  height: 80,
                                  width: _width/3,
                                  color:_profilePage != CusProfilePages.BookedHistory?AppData.primaryColor:AppData.primaryColor2,
                                  child: Icon(
                                    Icons.history,
                                    color:AppData.whiteColor,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ):Container()
                      ],
                    ),
                  ) ,
                ),

                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: <Widget>[
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NO"),
            ),
            SizedBox(height: 16),
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Text("YES"),
            ),
          ],
        ),
      ) ??
          false;
        
  }

  List<Widget> _appDrawerContent() {
    return [
      Container(
        height: 300,
        child: Padding(
          padding:  EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.only(bottom: 50.0),
                child: Center(
                  child: Container(
                      height: 120,
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              Text(
                widget.user.name,
                style: TextStyle(color: AppData.whiteColor, fontSize: 17,fontWeight: FontWeight.w600),
              ),
              
              SizedBox(
                height:5
              ),

              Text(
                widget.user.email,
                style: TextStyle(color: AppData.whiteColor, fontSize: 17,fontWeight: FontWeight.w600),
              ),

              
              SizedBox(
                height:5
              ),

              
              SizedBox(
                height:5
              ),


            ],
          ),
        ),
      ),
      Container(
        height: _height-300,
        color: AppData.whiteColor,
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                color: AppData.primaryColor,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    color: AppData.blackColor,
                    height: 5,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  "Edit Details",
                  style: TextStyle(color: AppData.blackColor, fontSize: 15),
                ),
                trailing: Icon(
                  Icons.description,
                  color: AppData.blackColor,
                ),
                onTap:() {
                  _scaffoldKey.currentState.openEndDrawer();
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, _, __) => EditUserDetails(
                        user: widget.user,
                      ),
                      opaque: false
                    ),
                  );
                },
              ),
              widget.user.userType == UserType.Admin?ListTile(
                title: Text(
                  "Add Bus Owner",
                  style: TextStyle(color: AppData.blackColor, fontSize: 15),
                ),
                trailing: Icon(
                  Icons.bus_alert,
                  color: AppData.blackColor,
                ),
                onTap:() {
                  _scaffoldKey.currentState.openEndDrawer();
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, _, __) => AddBusOwner(
                        
                      ),
                      opaque: false
                    ),
                  );
                },
              ):Container(),
              widget.user.userType == UserType.Admin?ListTile(
                title: Text(
                  "Add Admin",
                  style: TextStyle(color: AppData.blackColor, fontSize: 15),
                ),
                trailing: Icon(
                  Icons.admin_panel_settings,
                  color: AppData.blackColor,
                ),
                onTap:() {
                  _scaffoldKey.currentState.openEndDrawer();
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, _, __) => EditAdminList(
                        user: widget.user,
                      ),
                      opaque: false
                    ),
                  );
                },
              ):Container(),
              ListTile(
                title: Text(
                  "Change password",
                  style: TextStyle(color: AppData.blackColor, fontSize: 15),
                ),
                trailing: Icon(
                  Icons.enhanced_encryption,
                  color: AppData.blackColor,
                ),
                onTap:() {
                  _scaffoldKey.currentState.openEndDrawer();
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, _, __) => UpdatePassword(
                        user: widget.user,
                      ),
                      opaque: false
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  "Privacy Policy",
                  style: TextStyle(color: AppData.blackColor, fontSize: 15),
                ),
                trailing: Icon(
                  Icons.privacy_tip,
                  color: AppData.blackColor,
                ),
                onTap:() {
                  _scaffoldKey.currentState.openEndDrawer();
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, _, __) => PrivacyPolicy(),
                      opaque: false
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  "About us",
                  style: TextStyle(color: AppData.blackColor, fontSize: 15),
                ),
                trailing: Icon(
                  Icons.info,
                  color: AppData.blackColor,
                ),
                onTap:() {
                  _scaffoldKey.currentState.openEndDrawer();
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, _, __) => AboutUs(),
                      opaque: false
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  "Rate us",
                  style: TextStyle(color: AppData.blackColor, fontSize: 15),
                ),
                trailing: Icon(
                  Icons.rate_review,
                  color: AppData.blackColor,
                ),
                onTap:() {
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
              ListTile(
                title: Text(
                  "Log Out",
                  style: TextStyle(color: AppData.blackColor, fontSize: 15),
                ),
                trailing: Icon(
                  Icons.exit_to_app,
                  color: AppData.blackColor,
                ),
                onTap:() async {
                  _scaffoldKey.currentState.openEndDrawer();
                  final storage = new FlutterSecureStorage();
                  await storage.deleteAll();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginBase(),
                    )
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  moveToPage(CusProfilePages page) {
    if(CusProfilePages.SelectLocation == page){
      _tabController.animateTo(0);
      if(mounted){
        setState(() {
          _profilePage = CusProfilePages.Add;
        });
      } 
    }else if(CusProfilePages.BookedTrip == page){
      _tabController.animateTo(1);
      if(mounted){
        setState(() {
          _profilePage = CusProfilePages.BookedTrip;
        });
      } 
    }else if(CusProfilePages.BookedHistory == page){
      _tabController.animateTo(2);
      if(mounted){
        setState(() {
          _profilePage = CusProfilePages.BookedHistory;
        });
      }
    }
  }

  @override
  openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

}

abstract class ProfileBaseListener{
  moveToPage(CusProfilePages page);
  openDrawer();
}

enum CusProfilePages{
  Add,
  SelectLocation,
  SelectBus,
  SelectSeat,
  PayForSeat,
  BookedTrip,
  BookedSeat,
  LiveLocation,
  BookedHistory,
}