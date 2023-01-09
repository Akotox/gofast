import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
    final FirebaseAuth _auth = FirebaseAuth.instance;

  late Stream<QuerySnapshot<Map<String, dynamic>>> _accepted;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _picked;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _dispatched;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _dropoff;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _jobStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _warehouse;

  String? category;


}
