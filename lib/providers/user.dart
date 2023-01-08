import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ShipmentProvider with ChangeNotifier{
 DocumentSnapshot?  user;


 getShipment(userDetails){
  user = userDetails;
  notifyListeners();
 }
}