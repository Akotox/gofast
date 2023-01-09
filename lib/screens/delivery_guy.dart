import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/widgets/shipment_streams/delivery_page.dart';
import 'package:intl/intl.dart';



import 'package:lottie/lottie.dart';

class DeliveryBoy extends StatefulWidget {
  const DeliveryBoy({super.key});

  @override
  State<DeliveryBoy> createState() => _DeliveryBoyState();
}

class _DeliveryBoyState extends State<DeliveryBoy> {
  String? category;
  String? scanResult;

  String? address;
  String? plate;
  String? phoneNumber;
  String? userImage;
  String? company;
  bool? idVerification;
  bool? courierVerification;
  bool _isLoading = false;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _deliveries;

  @override
  void initState() {
    super.initState();
    // getMyData();

    _deliveries = FirebaseFirestore.instance
        .collection('courier')
        .where('category', isEqualTo: category)
        .where('pickup', isEqualTo: false)
        .where('accepted', isEqualTo: false)
        .orderBy('createdAt', descending: false)
        .snapshots();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).iconTheme.color,
      body: SingleChildScrollView(
        child: Column(
          
          children: [
            incomingContent(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 8),
              child: Container(
                height: MediaQuery.of(context).size.height*0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFFFFFF).withOpacity(0.1),
                        const Color(0xFF03608F).withOpacity(0.5)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 10),
                  child: Deliveries(deliveries: _deliveries),
                ),
              ),
            )
          ],
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
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Lottie.asset('assets/json/delivery.json',
                      width: 50, height: 50),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Delivery Pick Center",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
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
                      onTap: () {
                        scanBarCode();
                      },
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
                height: 0,
              ),
            ],
          ),
        ),
      ),
    );
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

    setState(() {
      var date = DateFormat("MM-dd kk:mm").format(DateTime.now());
      this.scanResult = scanResult;

      final shipmentId = scanResult;
      FirebaseFirestore.instance.collection('courier').doc(shipmentId).update({
        'courierId': FirebaseAuth.instance.currentUser!.uid,
        'courierNumber': munhu!.phoneNumber,
        'vehicle': munhu!.plate,
        'pickup': true,
        'pickedAt': DateTime.now(),
        'company': munhu!.company,
        'accepted': true,
        'progress': 0,
      });
    });
  
  }
}
