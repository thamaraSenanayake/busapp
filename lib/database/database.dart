import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickbussl/model/user.dart';
import 'package:quickbussl/res/typeConvert.dart';

class Database{
  final CollectionReference users = Firestore.instance.collection('user');

  Future<User> login(String email, String password ) async{
    QuerySnapshot querySnapshot;

    querySnapshot = await users
    .where('email',isEqualTo: email )
    .where('password',isEqualTo: password)
    .getDocuments();

    if(querySnapshot.documents.length == 0){
      return null;
    }
      
    return _setUser(querySnapshot);;
  }

  Future<User> _setUser(QuerySnapshot querySnapshot) async {
    User user;
    for (var item in querySnapshot.documents) {
      
      user = User()
        ..email = item["email"]
        ..name = item["name"]
        ..password = item["password"]
        ..idNum = item["idNum"]
        ..phone = item["phone"]
        ..userType =TypeConvert().stringToUserType(item["userType"]);
    }

    return user;
  }

  Future addUser(User user) async{
    await users.document(user.email).setData({
      "email":user.email,
      "name":user.name,
      "password":user.password,
      "idNum":user.idNum,
      "phone":user.phone,
      "userType":TypeConvert().userTypeToString( user.userType),
    });
  }

  Future updateUser(User user) async{
    await users.document(user.email).updateData({
      "name":user.name,
      "idNum":user.idNum,
      "phone":user.phone,
    });
  }
  
}