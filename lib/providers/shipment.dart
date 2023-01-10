import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ShipmentProvider with ChangeNotifier{
 DocumentSnapshot?  shipment;


 getShipment(shipmentDetails){
  shipment = shipmentDetails;
  notifyListeners();
 }
}