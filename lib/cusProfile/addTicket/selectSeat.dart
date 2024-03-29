import 'package:flutter/material.dart';
// import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:quickbussl/const.dart';
import 'package:quickbussl/cusProfile/addTicket/addDetails.dart';
import 'package:quickbussl/model/seat.dart';
import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/module/customButton.dart';

class SelectSeat extends StatefulWidget {
  final Trip trip;
  final User user;
  final Function(List<Seat>) nextPage; 
  SelectSeat({Key key,@required this.trip,@required this.nextPage,@required this.user}) : super(key: key);

  @override
  _SelectSeatState createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  double _width = 0.0;
  double _seatHeight = 10.0;
  double _rowHeight = 14.0;
  double _height = 0;
  List<Seat> seatCount;
  Widget _seats;
  String _error = '';


  _smallBus(){
    _rowHeight = (_height-252)/10;
    _seatHeight = _rowHeight - 4;
    

    _seats =
      Column(
        children: [
          smallBusRow([0],seatCount[0].status,null, null),
          smallBusRow([1,2,3],seatCount[1].status,seatCount[2].status, seatCount[3].status),
          smallBusRow([4,5,6],seatCount[4].status,seatCount[5].status, seatCount[6].status),
          smallBusRow([7,8,9],seatCount[7].status,seatCount[8].status, seatCount[9].status),
          smallBusRow([10,11,12],seatCount[10].status,seatCount[11].status, seatCount[12].status),
          smallBusRow([13,14,15],seatCount[13].status,seatCount[14].status, seatCount[15].status),
          smallBusRow([16,17,18],seatCount[16].status,seatCount[17].status, seatCount[18].status),
          smallBusRow([19,20,21],seatCount[19].status,seatCount[20].status, seatCount[21].status),
          smallBusRow([22,23,24],seatCount[22].status,seatCount[23].status, seatCount[24].status),
          smallBusRow([25,27,28,26],seatCount[25].status,seatCount[27].status, seatCount[28].status,four:seatCount[26].status),
        ],
      );
      setState(() {
        
      });
  }

  Widget smallBusRow(List<int> index,int one,int two, int three,{int four}){
    return(
      Container(
        width: _width - 40,
        height:_rowHeight,
        child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              one != null? Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: () async {
                    if(seatCount[index[0]].status == 0 || seatCount[index[0]].status == 4){
                      Seat seat = await Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) => AddDetails(
                            seat:seatCount[index[0]],
                            user: widget.user, 
                            trip: widget.trip,
                          ),
                          opaque: false
                        ),
                      );
                      if(seat.getInPlace.isNotEmpty){
                        seatCount[index[0]]=seat;
                        seatCount[index[0]].status = 4;
                        setState(() {
                          _error = "";
                        });
                      }
                      _smallBus();
                    }
                  },
                  child: Container(
                    height: _seatHeight,
                    width:_seatHeight,
                    color: one == 0 || one == 4?AppData.greenColor:AppData.primaryColor ,
                    child:Stack(
                      children:[
                       Padding(
                         padding: const EdgeInsets.all(3.0),
                         child: Text(
                           (index[0]+1).toString(),
                            style: TextStyle(color: AppData.whiteColor,fontSize:15),
                         ),
                       ), 
                      
                    one == 1 || one == 3?
                    Center(
                      child: Icon(
                        Icons.event_seat_sharp,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):one == 4? Center(
                      child: Icon(
                        Icons.check,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):Container(),])
                  ),
                ),
              ):Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: _seatHeight,
                  width:_seatHeight,
                ),
              ),
              four == null ?Expanded(
                child: Container(
                  height: _seatHeight,
                ),
              ):Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: () async {
                    if(seatCount[index[3]].status == 0 || seatCount[index[3]].status == 4){
                      Seat seat = await Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) => AddDetails(
                            seat:seatCount[index[3]],
                            user: widget.user,
                            trip: widget.trip,
                          ),
                          opaque: false
                        ),
                      );
                      if(seat.getInPlace.isNotEmpty){
                        seatCount[index[3]]=seat;
                        seatCount[index[3]].status = 4;
                        setState(() {
                          _error = "";
                        });
                      }
                      _smallBus();
                    }
                  },
                  child: Container(
                    height: _seatHeight,
                    width:_seatHeight,
                    color: four == 0 || four == 4?AppData.greenColor:AppData.primaryColor ,
                    child:Stack(
                      children:[
                       Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          (index[3] + 1).toString(),
                          style: TextStyle(color: AppData.whiteColor,fontSize:15),
                        ),
                       ), 
                      
                    four == 1 || four == 3?
                    Center(
                      child: Icon(
                        Icons.event_seat_sharp,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):four == 4? Center(
                      child: Icon(
                        Icons.check,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):Container(),])
                  ),
                ),
              ),
              two != null? Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: () async {
                    if(seatCount[index[1]].status == 0 || seatCount[index[1]].status == 4){
                      Seat seat = await Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) => AddDetails(
                            seat:seatCount[index[1]],
                            user: widget.user,
                            trip: widget.trip,
                          ),
                          opaque: false
                        ),
                      );
                      if(seat.getInPlace.isNotEmpty){
                        seatCount[index[1]]=seat;
                        seatCount[index[1]].status = 4;
                        setState(() {
                          _error = "";
                        });
                      }
                      _smallBus();
                    }
                  },
                  child: Container(
                    height: _seatHeight,
                    width:_seatHeight,
                    color: two == 0 || two == 4?AppData.greenColor:AppData.primaryColor ,
                    child:Stack(
                      children:[
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            (index[1]+1).toString(),
                            style: TextStyle(color: AppData.whiteColor,fontSize:15),
                          ),
                        ), 
                      
                    two == 1 || two == 3?
                    Center(
                      child: Icon(
                        Icons.event_seat_sharp,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):two == 4? Center(
                      child: Icon(
                        Icons.check,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):Container(),])
                  ),
                ),
              ):Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: _seatHeight,
                  width:_seatHeight,
                ),
              ),
             three != null? Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: () async {
                    if(seatCount[index[2]].status == 0 || seatCount[index[2]].status == 4){
                      Seat seat = await Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) => AddDetails(
                            seat:seatCount[index[2]],
                            user: widget.user,
                            trip: widget.trip,
                          ),
                          opaque: false
                        ),
                      );
                      if(seat.getInPlace.isNotEmpty){
                        seatCount[index[2]]=seat;
                        seatCount[index[2]].status = 4;
                        setState(() {
                          _error = "";
                        });
                      }
                      _smallBus();
                    }
                  },
                  child: Container(
                    height: _seatHeight,
                    width:_seatHeight,
                    color: three == 0 || three == 4?AppData.greenColor:AppData.primaryColor ,
                    child:Stack(
                      children:[
                       Padding(
                         padding: const EdgeInsets.all(3.0),
                         child: Text(
                           (index[2]+1).toString(),
                      style: TextStyle(color: AppData.whiteColor,fontSize:15),
                         ),
                       ), 
                      
                    three == 1 || three == 3?
                    Center(
                      child: Icon(
                        Icons.event_seat_sharp,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):three == 4? Center(
                      child: Icon(
                        Icons.check,
                        size : 30,
                        color:AppData.whiteColor
                      ),
                    ):Container(),])
                  ),
                ),
              ):Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: _seatHeight,
                  width:_seatHeight,
                ),
              )
            ],
          )
      )
    );

  }

  @override
  void initState() {
    super.initState();
    print(widget.trip);
   
    seatCount = widget.trip.seatList;
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      _smallBus();
    });
  }

  _done() async {
    int selectSeatCount = 0;
    double _total = 0;
    for (var item in seatCount) {
      if(item.status == 4){
        selectSeatCount++;
        _total+= item.ticketPrice;
      }
    }
    if(selectSeatCount == 0){
      setState(() {
        _error= "Select at least one seat";
      });
    }else{
      final String tokenizationKey = 'sandbox_8hxpnkht_kzdtzv2btm4p7s5j';

      // final request = BraintreeCreditCardRequest(
      //   cardNumber: '4111111111111111',
      //   expirationMonth: '12',
      //   expirationYear: '2021',
      // );
      // BraintreePaymentMethodNonce result = await Braintree.tokenizeCreditCard(
      //   'AblRpnan_5l0f6haR_0rBbn-f6rsDcejl3cwz14-rHz5atdhYoj4gyjEaujbvionPdy1apYo4vU1HHpz',
      //   request,
      // );
      // final request1 = BraintreeDropInRequest(
      //   tokenizationKey:'tokenizationKey',
      //   // clientToken: 'AblRpnan_5l0f6haR_0rBbn-f6rsDcejl3cwz14-rHz5atdhYoj4gyjEaujbvionPdy1apYo4vU1HHpz',
      //   collectDeviceData: true,
      //   googlePaymentRequest: BraintreeGooglePaymentRequest(
      //     totalPrice: _total.toString(),
      //     currencyCode: 'LKR',
      //     billingAddressRequired: false,
      //   ),
      //   paypalRequest: BraintreePayPalRequest(
      //     amount: _total.toString(),
      //     displayName: 'Example company',
      //   ),
      // );
      // BraintreeDropInResult result1 = await BraintreeDropIn.start(request1);

      widget.nextPage(seatCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;
    });
    return Expanded(
      child: Column(
        children: [
          Container(
            width: _width,
            child: _seats,
          ),
          Text(
            _error,
            style: TextStyle(
              fontSize: 16,
              color: AppData.primaryColor2,
              fontWeight: FontWeight.w600
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:5.0),
            child: CustomButton(
              text: "Done", 
              buttonClick: (){
                _done();
                
              }
            ),
          )
        ],
      ),
    );
  }
}