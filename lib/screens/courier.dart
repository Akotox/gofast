import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/exports/exported_widgets.dart';
import 'package:gofast/global/global_variables.dart';
import 'package:gofast/screens/auth/login.dart';
import 'package:gofast/widgets/courier/accepted.dart';
import 'package:gofast/widgets/courier/delivered.dart';
import 'package:gofast/widgets/courier/dispatched.dart';
import 'package:gofast/widgets/courier/job.dart';
import 'package:gofast/widgets/warehouse_stream.dart';
import 'package:lottie/lottie.dart';

class CourierPage extends StatefulWidget {
  const CourierPage({super.key});

  @override
  State<CourierPage> createState() => _CourierPageState();
}

class _CourierPageState extends State<CourierPage>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(
    length: 4,
    vsync: this,
  );

  DateTime now = DateTime.now();
  String greeting = "";

  String? category;
  String? scanResult;
  String? plate;
  String? phoneNumber;
  String? company;
  bool? idVerification;
  bool? courierVerification;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late Stream<QuerySnapshot<Map<String, dynamic>>> _accepted;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _dispatched;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _dropoff;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _jobStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _warehouse;

  @override
  void initState() {
    super.initState();
    getGreeting();
    _jobStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('pickup', isEqualTo: false)
        .where('accepted', isEqualTo: false)
        .orderBy('createdAt', descending: false)
        .snapshots();

    _accepted = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('courierId', isEqualTo: _auth.currentUser!.uid)
        .where('pickup', isEqualTo: true)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();

    _warehouse = FirebaseFirestore.instance.collection('warehouse').snapshots();

    _dispatched = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('courierId', isEqualTo: _auth.currentUser!.uid)
        .where('pickup', isEqualTo: true)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: true)
        .where('delivered', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();

    _dropoff = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('courierId', isEqualTo: _auth.currentUser!.uid)
        .where('pickup', isEqualTo: true)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: true)
        .where('delivered', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots();

    getMyData();
  }

  void getMyData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userDoc == null) {
      return;
    } else {
      if (mounted) {
        setState(() {
          phoneNumber = userDoc.get('phoneNumber');
          location = userDoc.get('Address');
          name = userDoc.get('name');
          userImage = userDoc.get("userImage");
          email = userDoc.get("email");
          idVerification = userDoc.get('IdVerification');
          company = userDoc.get('company');
          plate = userDoc.get('plate');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).iconTheme.color,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            courierAppBar(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFFFFFF),
                      const Color(0xFF03608F).withOpacity(0.5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[300]),
                        child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              color: Theme.of(context)
                                  .progressIndicatorTheme
                                  .color,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            labelColor: Colors.white,
                            labelStyle: Theme.of(context).textTheme.headline4,
                            unselectedLabelColor: Colors.grey.withOpacity(0.7),
                            tabs: const [
                              Tab(
                                text: "Available",
                              ),
                              Tab(
                                text: "Accepted",
                              ),
                              Tab(
                                text: "Dispatch",
                              ),
                              Tab(
                                text: "Delivered",
                              )
                            ]),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                          controller: _tabController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            // Processing
                            Column(
                              children: [
                                Jobs(jobStream: _jobStream),
                              ],
                            ),

                            // Dispatch
                            Column(
                              children: [
                                Accepted(accepted: _accepted),
                              ],
                            ),

                            // Transit

                            Column(
                              children: [
                                Dispatched(dispatched: _dispatched),
                              ],
                            ),

                            // Delivered

                            Column(
                              children: [
                                DropOff(dropoff: _dropoff),
                              ],
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tools() {
    return Container(
        height: 40,
        decoration: BoxDecoration(
            color: Color(0xFFFFFFFF).withOpacity(0.7),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  scanBarCode();
                },
                child: Row(
                  children: [
                    const Icon(MaterialCommunityIcons.qrcode_scan),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'QR Scanner'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Row(
                  children: [
                    const Icon(
                      MaterialCommunityIcons.barcode_scan,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Barcode Scanner'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeliveryBoy()));
                },
                child: InkWell(
                  onTap: () {
                    warehousesList();
                  },
                  child: Row(
                    children: [
                      const Icon(MaterialCommunityIcons.warehouse),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Warehouses'.toUpperCase(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget courierAppBar() {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: Theme.of(context).iconTheme.color,
        image: const DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
            opacity: 0.3),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0, right: 16),
                        child: Text(
                          "$greeting  $name",
                          style: textStyle(16, Colors.white, FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const SizedBox(
                        height: 35,
                        width: 35,
                        child: CircleAvatar(
                          backgroundColor: Colors.white38,
                          backgroundImage: AssetImage("assets/images/user.png"),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Courier Center",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Lottie.asset('assets/json/delivery.json',
                      width: 50, height: 50),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              tools()
            ],
          ),
        ),
      ),
    );
  }

  void getGreeting() {
    int hours = now.hour;
    if (hours >= 1 && hours <= 12) {
      greeting = "Good Morning";
    } else if (hours >= 12 && hours <= 16) {
      greeting = "Good Afternoon";
    } else if (hours >= 16 && hours <= 21) {
      greeting = "Good Evening";
    } else if (hours >= 21 && hours <= 24) {
      greeting = "Good Night";
    }
  }

  warehousesList() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.74,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/images/extended.png"),
                      fit: BoxFit.cover,
                      opacity: 0.45),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(19),
                      topRight: Radius.circular(19)),
                  color: Colors.lightBlue.shade600),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: StorageStream(warehouse: _warehouse),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future scanBarCode() async {
    int progress = 2;
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#00FF00', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      scanResult = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      this.scanResult = scanResult;

      final shipmentId = scanResult;
      FirebaseFirestore.instance.collection('courier').doc(shipmentId).update({
        'courierId': FirebaseAuth.instance.currentUser!.uid,
        'courierNumber': phoneNumber,
        'vehicle': plate,
        'pickup': true,
        'pickedAt': DateTime.now(),
        'company': company,
        'accepted': true,
        'progress': progress,
      });
    });
  }
}
