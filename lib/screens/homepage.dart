import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/global/global_variables.dart';
import 'package:gofast/widgets/shipments/in_delivered.dart';
import 'package:gofast/widgets/shipments/in_dispatch.dart';
import 'package:gofast/widgets/shipments/in_processing.dart';
import 'package:gofast/widgets/shipments/in_transit.dart';
import 'package:gofast/widgets/shipments/out_dispatch.dart';
import 'package:gofast/widgets/shipments/out_processing.dart';
import 'package:gofast/widgets/shipments/out_transit.dart';
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
  final FirebaseAuth auth = FirebaseAuth.instance;


  late Stream<QuerySnapshot<Map<String, dynamic>>> _processingStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _processingReceiverStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _pickedStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _pickStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _intransitDeliveryStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _intransitStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _deliveredStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _deliveryStream;

  @override
  void initState() {
    super.initState();

    getMyData();
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
        .where('destinationNumber', isEqualTo: phoneNumber)
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
        .where('destinationNumber', isEqualTo: phoneNumber)
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
        .where('destinationNumber', isEqualTo: phoneNumber)
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
        .where('destinationNumber', isEqualTo: phoneNumber)
        .where('pickup', isEqualTo: true)
        .where('accepted', isEqualTo: true)
        .where('intransit', isEqualTo: true)
        .where('delivered', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  void getMyData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userDoc == null) {
      return;
    } else {
      setState(() {
        phoneNumber = userDoc.get('phoneNumber');
        location = userDoc.get('Address');
        name = userDoc.get('name');
      });
    }
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
            labelPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            labelColor: Theme.of(context).backgroundColor,
            labelStyle: Theme.of(context).textTheme.headline4,
            indicatorColor: Colors.transparent,
            // indicator: CircleTabIndicator(color: Colors.green, radius: 4),
            tabs:  [
              Tab(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(MaterialCommunityIcons.bike_fast),
                    SizedBox(width: 10,),
                    Text("Incoming Parcels"),
                  ],
                ),
              ),
              Tab(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(MaterialCommunityIcons.cube_send),
                    SizedBox(width: 10,),
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
            padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  gradient: LinearGradient(
                    colors:  [
                      const Color(0xFFFFFFFF).withOpacity(0.5),
                      const Color(0xFF03608F).withOpacity(0.5)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey[300]),
                      child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: const Color(0xFF03608F),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          labelColor: Colors.white,
                          labelStyle: Theme.of(context).textTheme.headline4,
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
                            )
                          ]),
                    ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [

                  // Processing
                  Column(
                    children: [
                      Processing(processingReceiverStream: _processingReceiverStream),
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
            padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  gradient: LinearGradient(
                    colors:  [
                      const Color(0xFFFFFFFF).withOpacity(0.5),
                      const Color(0xFF03608F).withOpacity(0.5)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey[300]),
                      child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: const Color(0xFF03608F),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          labelColor: Colors.white,
                          labelStyle: Theme.of(context).textTheme.headline4,
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
                            )
                          ]),
                    ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [

                  // Processing
                  Column(
                    children: [
                      OutProcessing(processingStream: _processingStream),
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
                      OutTransit(intransitDeliveryStream: _intransitDeliveryStream),
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
      ),
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
            opacity: 0.45),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20.0),
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
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
                            hintText:
                                "Search Using Parcel Number or Scan the QRCode",
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
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(MaterialCommunityIcons.cube_send),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Send Parcel'.toUpperCase(),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              MaterialCommunityIcons.barcode,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Collection ID'.toUpperCase(),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(MaterialCommunityIcons.truck_fast_outline),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Pick Up Parcel'.toUpperCase(),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }


  Widget incomingContent() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).iconTheme.color,
        image: const DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
            opacity: 0.45),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20.0),
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
              SizedBox(
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
                            hintText:
                                "Search Using Parcel Number or Scan the QRCode",
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
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(MaterialCommunityIcons.cube_send),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Send Parcel'.toUpperCase(),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              MaterialCommunityIcons.barcode,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Collection ID'.toUpperCase(),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(MaterialCommunityIcons.truck_fast_outline),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Pick Up Parcel'.toUpperCase(),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}











class outGoingTab extends StatelessWidget {
  const outGoingTab({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF).withOpacity(0.5),
                Color(0xFF03608F).withOpacity(0.5)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey[300]),
                child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Color(0xFF03608F),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelColor: Colors.white,
                    labelStyle: Theme.of(context).textTheme.headline4,
                    unselectedLabelColor: Colors.grey.withOpacity(0.7),
                    tabs: const [
                      Tab(
                        text: "Dispatch",
                      ),
                      Tab(
                        text: "Picked",
                      ),
                      Tab(
                        text: "Intransit",
                      ),
                      Tab(
                        text: "Delivered",
                      )
                    ]),
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 10, 20, 10),
                          child: Container(
                            child: Text("Welcome"),
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 10, 12, 10),
                        child: Text(
                          "widget.content",
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 10, 12, 10),
                        child: Text(
                          "widget.content",
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 10, 12, 10),
                        child: Text(
                          "widget.content",
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

