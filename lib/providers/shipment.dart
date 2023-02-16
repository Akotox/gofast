import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShipmentProvider with ChangeNotifier {
  DocumentSnapshot? shipment;
  DocumentSnapshot? thisUser;

  getShipment(shipmentDetails) {
    shipment = shipmentDetails;
    notifyListeners();
  }

  getUser(snapshot) {
    thisUser = snapshot;
    notifyListeners();
  }
}
