import 'package:quickbussl/model/trip.dart';
import 'package:quickbussl/model/user.dart';

class TypeConvert{
  UserType stringToUserType(String userType){
    if(UserType.Passenger.toString() == userType){
      return UserType.Passenger;
    }
    else if(UserType.BusOwner.toString() == userType){
      return UserType.BusOwner;
    }
    else{
      return UserType.Admin;
    }
  }

  String userTypeToString(UserType userType){
    if(UserType.Passenger == userType){
      return "UserType.Passenger";
    }
    else if(UserType.BusOwner == userType){
      return "UserType.BusOwner";
    }
    else{
      return "UserType.Admin";
    }
  }
  BusType stringToBusType(String busType){
    if(BusType.Small.toString() == busType){
      return BusType.Small;
    }
    else if(BusType.Medium.toString() == busType){
      return BusType.Medium;
    }
    else{
      return BusType.Large;
    }
  }

  String busTypeToString(BusType busType){
    if(BusType.Small == busType){
      return "BusType.Small";
    }
    else if(BusType.Medium == busType){
      return "BusType.Medium";
    }
    else{
      return "BusType.Large";
    }
  }
}