import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:glass/glass.dart';
import 'package:gofast/exports/exported_widgets.dart';
import 'package:gofast/global/global_variables.dart';
import 'package:gofast/screens/send_parcel_widget.dart';
import 'package:gofast/widgets/shipment_streams/in_delivered.dart';
import 'package:gofast/widgets/shipment_streams/in_dispatch.dart';
import 'package:gofast/widgets/shipment_streams/in_processing.dart';
import 'package:gofast/widgets/shipment_streams/in_transit.dart';
import 'package:gofast/widgets/shipment_streams/out_dispatch.dart';
import 'package:gofast/widgets/shipment_streams/out_processing.dart';
import 'package:gofast/widgets/shipment_streams/out_transit.dart';
import 'package:gofast/widgets/warehouse_stream.dart';
import 'package:intl/intl.dart';

import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController = TabController(
    length: 4,
    vsync: this,
  );

  String? category;
  String? results;
  bool? courierVerification;
  final FirebaseAuth auth = FirebaseAuth.instance;

  late Stream<QuerySnapshot<Map<String, dynamic>>> _processingStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _processingReceiverStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _pickedStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _pickStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _intransitDeliveryStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _intransitStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _deliveredStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _deliveryStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _warehouse;

  @override
  void initState() {
    super.initState();

    getStreams();
  }

  void getStreams() {
    _warehouse = FirebaseFirestore.instance.collection('warehouse').snapshots();

    _processingStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('sendBy', isEqualTo: auth.currentUser!.uid)
        .where('pickup', isEqualTo: false)
        .where('accepted', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();

    _processingReceiverStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('destinationNumber', isEqualTo: munhu!.phoneNumber)
        .where('pickup', isEqualTo: false)
        .where('accepted', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();

    _pickedStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('sendBy', isEqualTo: auth.currentUser!.uid)
        .where('pickup', isEqualTo: true)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();

    _pickStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('destinationNumber', isEqualTo: munhu!.phoneNumber)
        .where('pickup', isEqualTo: true)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();

    _intransitDeliveryStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('sendBy', isEqualTo: auth.currentUser!.uid)
        .where('pickup', isEqualTo: true)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: true)
        .where('delivered', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();

    _intransitStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('destinationNumber', isEqualTo: munhu!.phoneNumber)
        .where('pickup', isEqualTo: true)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: true)
        .where('delivered', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();

    _deliveredStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('sendBy', isEqualTo: auth.currentUser!.uid)
        .where('pickup', isEqualTo: true)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: true)
        .where('delivered', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots();

    _deliveryStream = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('destinationNumber', isEqualTo: munhu!.phoneNumber)
        .where('pickup', isEqualTo: true)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: true)
        .where('delivered', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).iconTheme.color,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          bottom: TabBar(
            indicatorWeight: 1,
            splashBorderRadius: const BorderRadius.all(Radius.circular(30)),
            unselectedLabelColor: Colors.grey.withOpacity(0.7),

            labelColor: Theme.of(context).backgroundColor,
            labelStyle: Theme.of(context).textTheme.headline4,
            indicatorColor: Colors.transparent,
            // indicator: CircleTabIndicator(color: Colors.green, radius: 4),
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(MaterialCommunityIcons.bike_fast),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Incoming Parcels"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(MaterialCommunityIcons.cube_send),
                    SizedBox(
                      width: 10,
                    ),
                    Text("OutGoing Parcels"),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  incomingContent(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                      Theme.of(context).textTheme.headline4,
                                  unselectedLabelColor:
                                      Colors.grey.withOpacity(0.7),
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
                                    )
                                  ]),
                            ).asGlass(
                                tintColor: Theme.of(context).dividerColor,
                                clipBorderRadius: BorderRadius.circular(19.0),
                                blurX: 8,
                                blurY: 8),
                          ),
                          Expanded(
                            child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _tabController,
                                children: [
                                  // Processing
                                  Column(
                                    children: [
                                      Processing(
                                          processingReceiverStream:
                                              _processingReceiverStream),
                                    ],
                                  ),

                                  // Dispatch
                                  Column(
                                    children: [
                                      OutDispatch(pickStream: _pickStream),
                                    ],
                                  ),

                                  // Transit

                                  Column(
                                    children: [
                                      Transit(
                                          intransitStream: _intransitStream),
                                    ],
                                  ),

                                  // Delivered

                                  Column(
                                    children: [
                                      Delivered(
                                          deliveryStream: _deliveryStream),
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
            SingleChildScrollView(
              child: Column(
                children: [
                  outGoingContent(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                      Theme.of(context).textTheme.headline4,
                                  unselectedLabelColor:
                                      Colors.grey.withOpacity(0.7),
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
                                    )
                                  ]),
                            ).asGlass(
                                tintColor: Theme.of(context).dividerColor,
                                clipBorderRadius: BorderRadius.circular(19.0),
                                blurX: 8,
                                blurY: 8),
                          ),
                          Expanded(
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  // Processing
                                  Column(
                                    children: [
                                      OutProcessing(
                                          processingStream: _processingStream),
                                    ],
                                  ),

                                  // Dispatch
                                  Column(
                                    children: [
                                      Dispatch(pickedStream: _pickedStream),
                                    ],
                                  ),

                                  // Transit

                                  Column(
                                    children: [
                                      OutTransit(
                                          intransitDeliveryStream:
                                              _intransitDeliveryStream),
                                    ],
                                  ),

                                  // Delivered

                                  Column(
                                    children: [
                                      Delivered(
                                          deliveryStream: _deliveryStream),
                                    ],
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ).asGlass(
                        tintColor: Theme.of(context).dividerColor,
                        clipBorderRadius: BorderRadius.circular(19.0),
                        blurX: 8,
                        blurY: 8),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget outGoingContent() {
    return Container(
      height: 200,
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
          padding: const EdgeInsets.fromLTRB(10, 0, 8, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Lottie.asset('assets/json/delivery.json',
                      width: 50, height: 50),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "OutGoing Parcels",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
              search(),
              const SizedBox(
                height: 10,
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Steppa()));
                },
                child: Row(
                  children: [
                    const Icon(MaterialCommunityIcons.cube_send),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Send Parcel'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  idCode();
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
                      'Identification Code'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              InkWell(
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
            ],
          ),
        ));
  }

  Widget incomingContent() {
    return Container(
      height: 200,
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
                children: [
                  Lottie.asset('assets/json/delivery.json',
                      width: 50, height: 50),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Incoming Parcels",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              search(),
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

  Widget search() {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).backgroundColor,
              ),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    AntDesign.search1,
                    color: Color(0xFF03608F),
                  ),
                  hintText: "Search Using Parcel Number or Scan the QRCode",
                  hintStyle: Theme.of(context).textTheme.headline6,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 50,
              height: 49,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).backgroundColor,
              ),
              child: const Icon(MaterialCommunityIcons.qrcode_scan),
            ),
          )
        ],
      ),
    );
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
              height: MediaQuery.of(context).size.height * 0.661,
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

  idCode() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.661,
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
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(19),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFFFFFFF),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          const SizedBox(
                            height: 50,
                            width: 50,
                            child: CircleAvatar(
                              backgroundColor: Colors.white38,
                              backgroundImage:
                                  AssetImage("assets/images/user.png"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Stack(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(
                                      right: 30, left: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text(
                                    "${munhu!.name}",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  )),
                              const Positioned(
                                right: 0,
                                child: Icon(AntDesign.checkcircle, size: 20),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: BarcodeWidget(
                                  data: "${munhu!.phoneNumber}.${munhu!.name}",
                                  barcode: Barcode.code128(),
                                  drawText: false,
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 4, top: 10),
                                  backgroundColor: Colors.black,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                              Text(
                                "This barcode is used to verify your identity before parcel collection.",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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

    if (scanResult.contains("search")) {
    } else if (scanResult.contains("search")) {
    } else {}
  }
}
