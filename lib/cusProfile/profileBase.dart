import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:quickbussl/cusProfile/addTicket/addTicket.dart';
import 'package:quickbussl/cusProfile/bookedHistory.dart';
import 'package:quickbussl/cusProfile/bookedTrip.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';

import '../const.dart';

class CusProfile extends StatefulWidget {
  final User user;
  CusProfile({Key key,@required this.user}) : super(key: key);

  @override
  _CusProfileState createState() => _CusProfileState();
}

class _CusProfileState extends State<CusProfile> with TickerProviderStateMixin {
  double _height  =0.0;
  double _width =0.0;
  bool _bottomBarVisibility = true;
  String _title = "Enter Location";
  CusProfilePages _profilePage =CusProfilePages.Add;
  TabController _tabController;
  Trip _trip = Trip();

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
                                // search: (){
                                //   // _profilePage = Profile
                                // },
                              ),
                              BookedTrip(trip: _trip,),
                              BookedHistory(trip: _trip),
                            ],
                          )
                        ),
                        _bottomBarVisibility?Container(
                          height: 50,
                          color: AppData.primaryColor,
                          child: TabBar(
                            indicatorColor:AppData.whiteColor,
                            indicatorWeight: 4,
                            indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
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
                                  width: 80,
                                  color: AppData.primaryColor,
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
                                  width: 80,
                                  color: AppData.primaryColor,
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
                                  width: 80,
                                  color: AppData.primaryColor,
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