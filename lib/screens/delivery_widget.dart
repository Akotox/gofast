import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:async/async.dart' show StreamGroup;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class DeliveryWigdet extends StatefulWidget {
  static const String id = 'deliveries';

  const DeliveryWigdet({Key? key}) : super(key: key);

  @override
  State<DeliveryWigdet> createState() => _DeliveryWigdetState();
}

class _DeliveryWigdetState extends State<DeliveryWigdet> {
  String? category;
  // final FirebaseAuth auth = FirebaseAuth.instance;

  // late Stream<QuerySnapshot<Map<String, dynamic>>> _processes;
  // late Stream<QuerySnapshot<Map<String, dynamic>>> _picked;
  // late Stream<QuerySnapshot<Map<String, dynamic>>> _transit;
  // late Stream<QuerySnapshot<Map<String, dynamic>>> _processingStream;
  // late Stream<QuerySnapshot<Map<String, dynamic>>> _processingReceiverStream;
  // late Stream<QuerySnapshot<Map<String, dynamic>>> _pickedStream;
  // late Stream<QuerySnapshot<Map<String, dynamic>>> _pickStream;
  // late Stream<QuerySnapshot<Map<String, dynamic>>> _completedStream;
  // late Stream<QuerySnapshot<Map<String, dynamic>>> _intransitDeliveryStream;
  // late Stream<QuerySnapshot<Map<String, dynamic>>> _intransitStream;
  // late Stream<QuerySnapshot<Map<String, dynamic>>> _deliveredStream;
  // late Stream<QuerySnapshot<Map<String, dynamic>>> _deliveryStream;

  @override
  // void initState() {
  //   super.initState();

  //   getMyData();
  //   _processingStream =
  //       FirebaseFirestore.instance
  //       .collection('courier')
  //       .where('category', isEqualTo: category)
  //       .where('sendBy', isEqualTo: auth.currentUser!.uid)
  //       .where('pickup', isEqualTo: false)
  //       .where('accepted', isEqualTo: false)
  //       .orderBy('createdAt', descending: true)
  //       .snapshots();

  //   _processingReceiverStream =
  //       FirebaseFirestore.instance
  //           .collection('courier')
  //           .where('category', isEqualTo: category)
  //           .where('destinationNumber', isEqualTo: phoneNumber)
  //           .where('pickup', isEqualTo: false)
  //           .where('accepted', isEqualTo: false)
  //           .orderBy('createdAt', descending: true)
  //           .snapshots();

  //   _pickedStream = FirebaseFirestore.instance
  //       .collection('courier')
  //       .where('category', isEqualTo: category)
  //       .where('sendBy', isEqualTo: auth.currentUser!.uid)
  //       .where('pickup', isEqualTo: true)
  //       .where('accepted', isEqualTo: true)
  //       .where('intransit', isEqualTo: false)
  //       .orderBy('createdAt', descending: true)
  //       .snapshots();

  //   _pickStream = FirebaseFirestore.instance
  //       .collection('courier')
  //       .where('category', isEqualTo: category)
  //       .where('destinationNumber', isEqualTo: phoneNumber)
  //       .where('pickup', isEqualTo: true)
  //       .where('accepted', isEqualTo: true)
  //       .where('intransit', isEqualTo: false)
  //       .orderBy('createdAt', descending: true)
  //       .snapshots();

  //   _intransitDeliveryStream = FirebaseFirestore.instance
  //       .collection('courier')
  //       .where('category', isEqualTo: category)
  //       .where('sendBy', isEqualTo: auth.currentUser!.uid)
  //       .where('pickup', isEqualTo: true)
  //       .where('accepted', isEqualTo: true)
  //       .where('intransit', isEqualTo: true)
  //       .where('delivered', isEqualTo: false)
  //       .orderBy('createdAt', descending: true)
  //       .snapshots();

  //   _intransitStream = FirebaseFirestore.instance
  //       .collection('courier')
  //       .where('category', isEqualTo: category)
  //       .where('destinationNumber', isEqualTo: phoneNumber)
  //       .where('pickup', isEqualTo: true)
  //       .where('accepted', isEqualTo: true)
  //       .where('intransit', isEqualTo: true)
  //       .where('delivered', isEqualTo: false)
  //       .orderBy('createdAt', descending: true)
  //       .snapshots();

  //   _transit = StreamGroup.mergeBroadcast([ _intransitStream, _intransitDeliveryStream,]);

  //   _deliveredStream = FirebaseFirestore.instance
  //       .collection('courier')
  //       .where('category', isEqualTo: category)
  //       .where('sendBy', isEqualTo: auth.currentUser!.uid)
  //       .where('pickup', isEqualTo: true)
  //       .where('accepted', isEqualTo: true)
  //       .where('intransit', isEqualTo: true)
  //       .where('delivered', isEqualTo: true)
  //       .orderBy('createdAt', descending: true)
  //       .snapshots();

  //   _deliveryStream = FirebaseFirestore.instance
  //       .collection('courier')
  //       .where('category', isEqualTo: category)
  //       .where('destinationNumber', isEqualTo: phoneNumber)
  //       .where('pickup', isEqualTo: true)
  //       .where('accepted', isEqualTo: true)
  //       .where('intransit', isEqualTo: true)
  //       .where('delivered', isEqualTo: true)
  //       .orderBy('createdAt', descending: true)
  //       .snapshots();

  //   _processes = StreamGroup.merge([_processingStream, _processingReceiverStream]).asBroadcastStream();
  //   _picked = StreamGroup.mergeBroadcast([_pickStream, _pickedStream]);
  //   _completedStream = StreamGroup.mergeBroadcast([ _deliveredStream,_deliveryStream,]);
  // }

  // void getMyData() async {
  //   final DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   if (userDoc == null){
  //     return;
  //   }else {
  //     setState(() {
  //       phoneNumber = userDoc.get('phoneNumber');
  //       location = userDoc.get('Address');
  //       name = userDoc.get('name');
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Text("Incoming", style: Theme.of(context).textTheme.headline4),
              SizedBox(
                width: 10,
              ),
              Text("OutGoing", style: Theme.of(context).textTheme.headline4),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: TabBar(
              indicatorWeight: 2,
              unselectedLabelColor: Colors.grey.shade600,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              labelPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),

              labelStyle: Theme.of(context).textTheme.headline4,
              labelColor: Color(0xFF03608F),
              indicatorPadding: EdgeInsets.only(left: 20, right: 20),
              indicatorColor: Color(0xFF03608F),
              // indicator: CircleTabIndicator(color: Colors.green, radius: 4),
              tabs: const [
                Tab(
                  text: ('Dispatch'),
                ),
                Tab(
                  text: ('Picked'),
                ),
                Tab(
                  text: ('In transit'),
                ),
                Tab(
                  text: ('Delivered'),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFE0DFDF),
                      image: DecorationImage(
                          image: AssetImage("assets/images/bg.png"),
                          fit: BoxFit.cover,
                          opacity: 0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50,
                  color: Colors.blue,
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50,
                  color: Colors.blue,
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShipmentShimmer extends StatelessWidget {
  const ShipmentShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade600,
      highlightColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).indicatorColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Parcels extends StatelessWidget {
  const Parcels({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.height * 0.15,
            child: Image.asset('assets/images/empty.png')),
        Text(
          "You don\'t have parcels yet",
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
