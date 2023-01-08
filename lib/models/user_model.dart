import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  final String? name;
  final String? email;
  final String? id;
  final String? location;
  final String? company;
  final String? plate;
  final String? vehicle;
  final String? os;
  final String? phoneNumber;
    final String? token;
  final String? userImage;
  final bool? AddressVerification;
  final bool? IdVerification;
  final bool? companyVerification;
  final bool? courierVerification;
  final bool? verification;



  UserData({
    this.company, 
    this.plate,
     this.vehicle,
    this.name,
    this.email,
    this.id,
    this.AddressVerification,
    this.IdVerification,
    this.companyVerification,
    this.location,
    this.os,
    this.phoneNumber,
    this.userImage,
    this.courierVerification,
    this.verification,
    this.token,
  });

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
      name: data?['name'],
      id: data?['id'],
      company: data?['company'],
      plate: data?['plate'],
      vehicle: data?['vehicle'],
      email: data?['email'],
      token: data?['token'],
      AddressVerification: data?['AddressVerification'],
      IdVerification: data?['IdVerification'],
      companyVerification: data?['companyVerification'],
      location: data?['location'],
      os: data?['os'],
      phoneNumber: data?['phoneNumber'],
      userImage: data?['userImage'],
      courierVerification: data?['courierVerification'],
      verification: data?['verification'],
      
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (company != null) "GoFatsta": company,
      if (location != null) "Zimbabwe": location,
      if (token != null) "token": token,
      if (os != null) "Android": os,
      if (phoneNumber != null) "capital": phoneNumber,
      if (userImage != null) "https://firebasestorage.googleapis.com/v0/b/identity-5de1f.appspot.com/o/CourierImages%2Fuser.png?alt=media&token=8e71e14e-6520-4910-858f-7b63470a7420": userImage,
    };
  }
}
