import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gofast/models/user_model.dart';

class UserProvider with ChangeNotifier{
 UserData?  user;


 getMuhu(userDetails){
  user = userDetails;
  notifyListeners();
 }
}