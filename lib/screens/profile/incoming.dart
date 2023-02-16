import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/exports/exported_widgets.dart';
import 'package:gofast/services/firebase_services.dart';
import 'package:gofast/widgets/divida.dart';

class IncomingDeliveries extends StatefulWidget {
  const IncomingDeliveries({super.key});

  @override
  State<IncomingDeliveries> createState() => _IncomingDeliveriesState();
}

class _IncomingDeliveriesState extends State<IncomingDeliveries>
    with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 4,
    vsync: this,
  );

  String? category;
  String? results;
  bool? courierVerification;
  String location = "1576 Tynwald South Harare Zimbabwe";

  FirebaseServices _services = FirebaseServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late Stream<QuerySnapshot<Map<String, dynamic>>> _processingReceiverStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _pickStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _intransitStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _deliveryStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _warehouse;






  @override
  void initState() {
    super.initState();
    getStreams();
    // print(munhu!.phoneNumber);
  }

  void getStreams() {
    _warehouse = FirebaseFirestore.instance.collection('warehouse').snapshots();

 
    _processingReceiverStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('destinationNumber', isEqualTo: munhu?.phoneNumber)
        .where('pickup', isEqualTo: false)
        .where('accepted', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();



    _pickStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('destinationNumber', isEqualTo: munhu?.phoneNumber)
        .where('pickup', isEqualTo: true)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();

    _intransitStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('destinationNumber', isEqualTo: munhu?.phoneNumber)
        .where('pickup', isEqualTo: true)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: true)
        .where('delivered', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();


    _deliveryStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('destinationNumber', isEqualTo: munhu?.phoneNumber)
        .where('pickup', isEqualTo: true)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: true)
        .where('delivered', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(CupertinoIcons.back)),
        backgroundColor: Colors.white,
        title: Text(
          "Incoming Deliveries",
          style: textStyle(16, Colors.black, FontWeight.w700),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            // minVerticalPadding: 0,
            leading: const Icon(
              Entypo.notification,
              size: 18,
            ),
            minLeadingWidth: 10,

            title: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 10),
              child: Text(
                "From: 10 Downing St, New York | To: 165 W 46th St, New YorkFrom: 10 Downing St, New York | To: 165 W 46th St, New YorkFrom: 10 Downing St, New York | To: 165 W 46th St, New York",
                style: textStyle(12, Colors.grey, FontWeight.w500),
                maxLines: 4,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          const Divida(),
          Flexible(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TabBar(
                        controller: _tabController,
                        // isScrollable: true,
                        indicator: BoxDecoration(
                          color: Theme.of(context).progressIndicatorTheme.color,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelColor: Colors.white,
                        labelStyle:
                            textStyle(12, Colors.black45, FontWeight.w600),
                        unselectedLabelColor: Colors.grey.withOpacity(0.7),
                        tabs: const [
                          Tab(
                            text: "Processing",
                          ),
                          Tab(
                            text: "Dispatch",
                          ),
                          Tab(
                            text: "Intransit",
                          ),
                          Tab(
                            text: "Delivered",
                          ),
                        ]),
                  ),
                ),
                Expanded(
                  child: TabBarView(controller: _tabController,
                      // physics: NeverScrollableScrollPhysics(),
                      children: [
                        // Processing
                        Column(
                          children: [
                            Processing(
                                processingReceiverStream:
                                    _processingReceiverStream),
                          ],
                        ),

                        Column(
                          children: [
                            OutDispatch(pickStream: _pickStream),
                          ],
                        ),

                        // Transit

                        Column(
                          children: [
                            Transit(intransitStream: _intransitStream),
                          ],
                        ),

                        // Delivered

                        Column(
                          children: [
                            Delivered(deliveryStream: _deliveryStream),
                          ],
                        ),
                      ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
