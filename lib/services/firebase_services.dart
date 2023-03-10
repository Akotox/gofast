import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
    final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  CollectionReference messages =
      FirebaseFirestore.instance.collection('courier');

  CollectionReference followers =
      FirebaseFirestore.instance.collection('followers');
  CollectionReference following =
      FirebaseFirestore.instance.collection('following');
  CollectionReference couriers =
      FirebaseFirestore.instance.collection('couriers');

  CollectionReference warehouse =
      FirebaseFirestore.instance.collection('warehouse');

  CollectionReference company =
      FirebaseFirestore.instance.collection('company');

  User? user = FirebaseAuth.instance.currentUser;
  Future<DocumentSnapshot> getUser() async {
    DocumentSnapshot userInfo = await users.doc(user!.uid).get();
    return userInfo;
  }

  Future<DocumentSnapshot> getSellerData(id) async {
    DocumentSnapshot doc = await users.doc(id).get();
    return doc;
  }

  Future<DocumentSnapshot> getProductDetails(id) async {
    DocumentSnapshot doc = await products.doc(id).get();
    return doc;
  }




}
