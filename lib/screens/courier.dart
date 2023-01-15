import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:glass/glass.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/models/user_model.dart';
import 'package:gofast/services/firebase_services.dart';
import 'package:gofast/widgets/courier_streams/accepted.dart';
import 'package:gofast/widgets/courier_streams/delivered.dart';
import 'package:gofast/widgets/courier_streams/dispatched.dart';
import 'package:gofast/widgets/courier_streams/job.dart';
import 'package:gofast/widgets/courier_streams/picked.dart';
import 'package:gofast/widgets/warehouse_stream.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CourierPage extends StatefulWidget {
  const CourierPage({
    super.key,
  });

  @override
  State<CourierPage> createState() => _CourierPageState();
}

class _CourierPageState extends State<CourierPage>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(
    length: 5,
    vsync: this,
  );

  DateTime now = DateTime.now();
  String greeting = "";
  FirebaseServices _services = FirebaseServices();

  String? category;
  String? scanResult;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late Stream<QuerySnapshot<Map<String, dynamic>>> _accepted;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _picked;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _dispatched;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _dropoff;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _jobStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _warehouse;
  // UserData? _munhu;

  @override
  void initState() {
    super.initState();
    getGreeting();
    getShipmentStreams();
    getDataOnce();
  }

  @override
  Widget build(BuildContext context) {
    var date = DateFormat("MMM d @ kk:mm").format(DateTime.now());

    return Scaffold(
      backgroundColor: Theme.of(context).iconTheme.color,
      appBar: AppBar(
        elevation: 0,
        title: Row(
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
                    "$greeting  ${munhu?.name ?? "Mkomana"}",
                    style: textStyle(16, Colors.white, FontWeight.bold),
                  ),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            courierAppBar(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
              child: Container(
                height: MediaQuery.of(context).size.height,
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
                        ),
                        child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              color: Theme.of(context)
                                  .progressIndicatorTheme
                                  .color,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            labelColor: Colors.white,
                            labelStyle:
                                textStyle(12, Colors.black45, FontWeight.w600),
                            unselectedLabelColor: Colors.grey.withOpacity(0.7),
                            tabs: const [
                              Tab(
                                text: "Jobs",
                              ),
                              Tab(
                                text: "Accepted",
                              ),
                              Tab(
                                text: "Picked",
                              ),
                              Tab(
                                text: "In-transit",
                              ),
                              Tab(
                                text: "Dropped",
                              )
                            ]),
                      ).asGlass(
                          tintColor: Theme.of(context).dividerColor,
                          clipBorderRadius: BorderRadius.circular(19.0),
                          blurX: 8,
                          blurY: 8),
                    ),
                    Expanded(
                      child: TabBarView(controller: _tabController,
                          // physics: NeverScrollableScrollPhysics(),
                          children: [
                            // Processing
                            Column(
                              children: [
                                Jobs(jobStream: _jobStream),
                              ],
                            ),

                            // Dispatch
                            Column(
                              children: [Accepted(accepted: _accepted)],
                            ),

                            Column(
                              children: [
                                Picked(picked: _picked),
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
                onTap: () {},
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
          padding: const EdgeInsets.fromLTRB(11, 0, 10, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 5,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //         child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(left: 2.0, right: 16),
              //           child: Text(
              //             "$greeting  ${munhu?.name}",
              //             style: textStyle(16, Colors.white, FontWeight.bold),
              //           ),
              //         ),
              //         const SizedBox(
              //           width: 5,
              //         ),
              //         const SizedBox(
              //           height: 35,
              //           width: 35,
              //           child: CircleAvatar(
              //             backgroundColor: Colors.white38,
              //             backgroundImage: AssetImage("assets/images/user.png"),
              //           ),
              //         ),
              //       ],
              //     )),
              //   ],
              // ),
              Row(
                children: [
                  Lottie.asset('assets/json/delivery.json',
                      width: 50, height: 50),
                  const SizedBox(
                    width: 8,
                  ),
                  Center(
                    child: Text(
                      "Courier Center",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
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
                 const SizedBox(height: 10,),
                   Container(
                    height: 5,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
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
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#00FF00', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      scanResult = 'Failed to get platform version.';
    }
    if (!mounted) return;

    if (scanResult.contains("parcel")) {
      setState(() {
        var shipmentId = scanResult.substring(1, 37);
        var progress = scanResult.substring(0, 1);
        var status = int.parse(progress.toString());

        status == 0 ? qrMethod(shipmentId, status) : () {};
        status == 1 ? qrMethod(shipmentId, status) : () {};
        status == 2 ? qrMethod(shipmentId, status) : () {};
        status == 3 ? qrMethod(shipmentId, status) : () {};
      });
    }
  }

  Future<dynamic> qrMethod(String shipmentId, int status) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black87,
        context: context,
        builder: (context) {
          String? buttontxt;
          if (status == 0) {
            buttontxt = "accept this job";
          } else if (status == 1) {
            buttontxt = "pick-up parcel";
          } else if (status == 2) {
            buttontxt = "Start Delivering";
          } else if (status == 3) {
            buttontxt = "Drop - off";
          } else if (status == 4) {
            buttontxt = "Delivered";
          }
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(7, 0, 7, 80),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/images/bg.png"),
                          fit: BoxFit.cover,
                          opacity: 0.45),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(19),
                      ),
                      color: Colors.lightBlue.shade600),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(19),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Welcome to Courier Center",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida. Risus commodo viverra maecenas accumsan lacus vel facilisis.",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton.icon(
                                    onPressed: () {
                                      var date = DateFormat("MM-dd kk:mm")
                                          .format(DateTime.now())
                                          .toString();
                                      var update = DateFormat("MMM d @ kk:mm")
                                          .format(DateTime.now())
                                          .toString();

                                      if (status == 0) {
                                        FirebaseFirestore.instance
                                            .collection('courier')
                                            .doc(shipmentId)
                                            .update({
                                          'courierId': FirebaseAuth
                                              .instance.currentUser!.uid,
                                          'courierNumber': munhu!.phoneNumber,
                                          'vehicle': munhu!.plate,
                                          'company': munhu!.company,
                                          'update': update,
                                          'image': munhu!.userImage,
                                          'accepted_at': date,
                                          'createdAt': date,
                                          'accepted': true,
                                          'progress': status + 1,
                                        });
                                        Future.delayed(const Duration(
                                                microseconds: 2000))
                                            .then((value) =>
                                                Navigator.pop(context));
                                      } else if (status == 1) {
                                        FirebaseFirestore.instance
                                            .collection('courier')
                                            .doc(shipmentId)
                                            .update({
                                          'update': update,
                                          'pickup': true,
                                          'pickedAt': date,
                                          'progress': status + 1,
                                        });
                                        Future.delayed(const Duration(
                                                microseconds: 2000))
                                            .then((value) =>
                                                Navigator.pop(context));
                                      } else if (status == 2) {
                                        FirebaseFirestore.instance
                                            .collection('courier')
                                            .doc(shipmentId)
                                            .update({
                                          'update': update,
                                          'intransit': true,
                                          'intransit_time': date,
                                          'progress': status + 1,
                                        });
                                        Future.delayed(const Duration(
                                                microseconds: 2000))
                                            .then((value) =>
                                                Navigator.pop(context));
                                      } else if (status == 3) {
                                        FirebaseFirestore.instance
                                            .collection('courier')
                                            .doc(shipmentId)
                                            .update({
                                          'update': update,
                                          'deliveredAt': date,
                                          'delivered': true,
                                          'progress': status + 1,
                                        });
                                        Future.delayed(const Duration(
                                                microseconds: 2000))
                                            .then((value) =>
                                                Navigator.pop(context));
                                      }
                                    },
                                    icon: const Icon(
                                      MaterialCommunityIcons
                                          .checkbox_marked_circle_outline,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                    label: Text(
                                      buttontxt!.toUpperCase(),
                                      style: textStyle(
                                          14, Colors.white, FontWeight.w500),
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -20,
                right: MediaQuery.of(context).size.width * 0.45,
                child: const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white38,
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void getShipmentStreams() {
    _jobStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('pickup', isEqualTo: false)
        .where('accepted', isEqualTo: false)
        .orderBy('createdAt', descending: false)
        .snapshots(includeMetadataChanges: false);

    _accepted = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('courierId', isEqualTo: _auth.currentUser!.uid)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();

    _picked = FirebaseFirestore.instance
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
  }

  void getDataOnce() async {
    final ref = _services.users.doc(_auth.currentUser?.uid).withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userdata, _) => userdata.toFirestore(),
        );
    final docSnap = await ref.get();
    final thisUser = docSnap.data(); // Convert to City object
    if (thisUser != null && mounted) {
      setState(() {
        munhu = thisUser;
      });
    }
  }
}
