class User{
  String email;
  String name;
  String password;
  String idNum;
  String phone;
  UserType userType;
}

enum UserType{
  Passenger,
  BusOwner,
  Admin
}