import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:url_launcher/url_launcher.dart';

class ShipmentDetailsScreen extends StatefulWidget {
  const ShipmentDetailsScreen({
    Key? key,
    required this.pickupAd,
    required this.shipmentId,
    required this.destination,
    required this.weight,
  }) : super(key: key);
  final String pickupAd;
  final String shipmentId;
  final String destination;
  final String weight;

  @override
  State<ShipmentDetailsScreen> createState() => _ShipmentDetailsScreenState();
}

class _ShipmentDetailsScreenState extends State<ShipmentDetailsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? category;
  bool? accepted;
  bool? delivered;
  bool? intransit;
  bool? pickup;
  String? shipmentId;
  String? courierId;
  String? courierNumber;
  Timestamp? createdAt;
  Timestamp? pickedAt;
  Timestamp? intransitAt;
  String? intransit_time;
  Timestamp? deliveredAt;
  Timestamp? pickedDateTimeStamp;
  Timestamp? transitDateTimeStamp;
  Timestamp? deliveredDateTimeStamp;
  String? destination;
  String? destinationNumber;
  String? pickupAd;
  String? pickupNumber;
  String? weight;
  String? postedDate;
  String? pickedDate;
  String? transitDate;
  String? deliveredDate;

  late String whatsappNo = "";
  late String message = "";

  @override
  void initState() {
    super.initState();
    getJobData();
  }

  void getJobData() async {
    final DocumentSnapshot shipment = await FirebaseFirestore.instance
        .collection('courier')
        .doc(widget.shipmentId)
        .get();
    if (shipment == null) {
      return;
    } else {
      if (mounted) {
        setState(() {
          shipmentId = shipment.get('shipmentId');
          weight = shipment.get('weight');
          delivered = shipment.get('delivered');
          accepted = shipment.get('accepted');
          category = shipment.get('category');
          courierId = shipment.get('courierId');
          courierNumber = shipment.get('courierNumber');
          pickup = shipment.get('pickup');
          intransit_time = shipment.get('intransit_time');
          intransit = shipment.get('intransit');
          destination = shipment.get('destination');
          destinationNumber = shipment.get('destinationNumber');
          pickupAd = shipment.get('pickupAd');
          pickupNumber = shipment.get('pickupNumber');
          pickedDateTimeStamp = shipment.get('pickedAt');
          transitDateTimeStamp = shipment.get('intransitAt');
          deliveredDateTimeStamp = shipment.get('deliveredAt');
          var pickDate = pickedDateTimeStamp?.toDate();
          pickedDate =
              '${pickDate?.month}-${pickDate?.day}  ${pickDate?.hour}:${pickDate?.minute}';
          var intransitDate = transitDateTimeStamp?.toDate();
          transitDate =
              '${intransitDate?.month}-${intransitDate?.day}  ${intransitDate?.hour}:${intransitDate?.minute}';
          var deliveryDate = deliveredDateTimeStamp?.toDate();
          deliveredDate =
              '${deliveryDate?.month}-${deliveryDate?.day}  ${deliveryDate?.hour}:${deliveryDate?.minute}';
        });
      }
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).iconTheme.color,
      appBar: AppBar(
        backgroundColor: Theme.of(context).iconTheme.color,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              AntDesign.leftcircleo,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin:
                      const EdgeInsets.only(right: 8.0, left: 8, bottom: 12),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Colors.white, Color(0xFF03608F)]),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${category == null ? '' : category!}  | ${weight == null ? '' : weight!}  kgs',
                                style: Theme.of(context).textTheme.headline4),
                            const SizedBox(
                              width: 10,
                            ),
                            delivered == true
                                ? Row(
                                    children: [
                                      Text('Delivered',
                                          style: textStyle(14, Colors.white,
                                              FontWeight.w500)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                          CupertinoIcons.check_mark_circled,
                                          size: 14,
                                          color: Colors.white)
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8, top: 35),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/bg.png"),
                          fit: BoxFit.cover,
                          opacity: 0.54),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      MaterialIcons.location_history,
                                      size: 13,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Origin :',
                                      style: textStyle(
                                          10, Colors.black, FontWeight.w800),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    Text(
                                      pickupAd == null ? '' : pickupAd!,
                                      textAlign: TextAlign.justify,
                                      style: textStyle(
                                          10, Colors.black87, FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.whatsapp_outlined,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Contact Sender :',
                                      style: textStyle(
                                          10, Colors.black, FontWeight.w800),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                InkWell(
                                  // onTap: accepted == true ?(){
                                  //   setState(() {
                                  //     whatsappNo = pickupNumber!;
                                  //     message="The courier is on the way to pick-up the parcel no. $shipmentId. Are you at $pickupAd? ";
                                  //   });
                                  //   _launchWhatsapp();
                                  // }: (){},
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 18,
                                      ),
                                      Text(
                                        pickupNumber == null
                                            ? ''
                                            : pickupNumber!,
                                        textAlign: TextAlign.justify,
                                        style: textStyle(10, Colors.black87,
                                            FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.location_solid,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Destination :',
                                      style: textStyle(
                                          10, Colors.black, FontWeight.w800),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    Text(
                                      destination == null ? '' : destination!,
                                      textAlign: TextAlign.justify,
                                      style: textStyle(
                                          10, Colors.black87, FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.whatsapp_outlined,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Contact Recever:',
                                      style: textStyle(
                                          10, Colors.black, FontWeight.w800),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                InkWell(
                                  // onTap: intransit == true ? (){
                                  //   setState(() {
                                  //     whatsappNo=destinationNumber!;
                                  //     message="$shipmentId is almost at the designated location $destination. Please confirm with a message, if you are at this location. Thank you. ";
                                  //   });
                                  //   _launchWhatsapp();
                                  // }: (){},
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 18,
                                      ),
                                      Text(
                                        destinationNumber == null
                                            ? ''
                                            : destinationNumber!,
                                        textAlign: TextAlign.justify,
                                        style: textStyle(10, Colors.black87,
                                            FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.14,
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: BarcodeWidget(
                              data: '$shipmentId',
                              barcode: Barcode.qrCode(),
                              drawText: false,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              backgroundColor: Colors.black,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.height * 0.41,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                        colors: [Colors.white, Color(0xFF03608F)]),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery Status',
                              style: Theme.of(context).textTheme.headline4),
                          accepted == true
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      whatsappNo = courierNumber!;
                                      message =
                                          'What\'s the delivery status of parcel $shipmentId?';
                                    });
                                    _launchWhatsapp();
                                  },
                                  icon: const Icon(Icons.whatsapp_outlined,
                                      color: Colors.white))
                              : const Icon(
                                  CupertinoIcons.phone_circle,
                                  color: Colors.grey,
                                )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      height: MediaQuery.of(context).size.height * 0.36,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black26),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(6, 18, 6, 6),
                                    child: Icon(CupertinoIcons
                                        .check_mark_circled_solid),
                                  ),
                                  Container(
                                    width: 1,
                                    height: MediaQuery.of(context).size.height *
                                        0.045,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Icon(MaterialIcons.location_history,
                                        color: pickup != true
                                            ? Colors.grey
                                            : Colors.green),
                                  ),
                                  Container(
                                    width: 1,
                                    height: MediaQuery.of(context).size.height *
                                        0.045,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Icon(CupertinoIcons.car_detailed,
                                        color: intransit != true
                                            ? Colors.grey
                                            : Colors.green),
                                  ),
                                  Container(
                                    width: 1,
                                    height: MediaQuery.of(context).size.height *
                                        0.045,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Icon(
                                      delivered != true
                                          ? CupertinoIcons.location_solid
                                          : CupertinoIcons
                                              .check_mark_circled_solid,
                                      color: delivered != true
                                          ? Colors.grey
                                          : Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 50,
                            top: 10,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Processing  ${postedDate == null ? '' : postedDate!}',
                                            style: textStyle(10, Colors.white,
                                                FontWeight.normal)),
                                        Text(pickupAd == null ? '' : pickupAd!,
                                            style: textStyle(10, Colors.white,
                                                FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Picked up ${pickedDate ?? ''}',
                                            style: textStyle(10, Colors.white,
                                                FontWeight.normal)),
                                        Text(pickupAd == null ? '' : pickupAd!,
                                            style: textStyle(10, Colors.white,
                                                FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.045,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Start transporting at ${transitDate ?? ''}',
                                            style: textStyle(10, Colors.white,
                                                FontWeight.normal)),
                                        Text(
                                            'The parcel arrives in ${intransit_time == null ? 'within the given time' : intransit_time!}',
                                            style: textStyle(10, Colors.white,
                                                FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.042,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('Delivered ${deliveredDate ?? ''}',
                                            style: textStyle(10, Colors.white,
                                                FontWeight.normal)),
                                        Text(
                                            destination == null
                                                ? ''
                                                : destination!,
                                            style: textStyle(10, Colors.white,
                                                FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // courierId != _auth.currentUser!.uid ||
                          //         courierId == null
                          //     ? Container()
                          //     : Positioned(
                          //         right: 20,
                          //         top: 0,
                          //         child: Align(
                          //           alignment: Alignment.centerLeft,
                          //           child: Column(
                          //             children: [
                          //               Padding(
                          //                 padding:
                          //                     const EdgeInsets.all(6.0),
                          //                 child: IconButton(
                          //                     onPressed: () {},
                          //                     icon: const Icon(CupertinoIcons
                          //                         .check_mark_circled_solid)),
                          //               ),
                          //               Container(
                          //                 width: 1,
                          //                 height: MediaQuery.of(context)
                          //                         .size
                          //                         .height *
                          //                     0.015,
                          //                 color: Colors.white,
                          //               ),
                          //               Padding(
                          //                 padding:
                          //                     const EdgeInsets.all(6.0),
                          //                 child: IconButton(
                          //                     onPressed: () {},
                          //                     icon: Icon(
                          //                       CupertinoIcons
                          //                           .location_solid,
                          //                       color: pickup != true
                          //                           ? Colors.grey
                          //                           : Colors.green,
                          //                     )),
                          //               ),
                          //               Container(
                          //                 width: 1,
                          //                 height: MediaQuery.of(context)
                          //                         .size
                          //                         .height *
                          //                     0.015,
                          //                 color: Colors.white,
                          //               ),
                          //               Padding(
                          //                 padding:
                          //                     const EdgeInsets.all(6.0),
                          //                 child: IconButton(
                          //                     onPressed: () {
                          //                       intransit != true
                          //                           ? _updateTransitTime()
                          //                           : () {};
                          //                     },
                          //                     icon: Icon(
                          //                       intransit == true
                          //                           ? CupertinoIcons
                          //                               .check_mark_circled_solid
                          //                           : CupertinoIcons
                          //                               .car_detailed,
                          //                       color: intransit != true
                          //                           ? Colors.grey
                          //                           : Colors.green,
                          //                     )),
                          //               ),
                          //               Container(
                          //                 width: 1,
                          //                 height: MediaQuery.of(context)
                          //                         .size
                          //                         .height *
                          //                     0.015,
                          //                 color: Colors.white,
                          //               ),
                          //               Padding(
                          //                 padding:
                          //                     const EdgeInsets.all(6.0),
                          //                 child: IconButton(
                          //                     onPressed: () {
                          //                       intransit == true ||
                          //                               pickup == true
                          //                           ? FirebaseFirestore
                          //                               .instance
                          //                               .collection(
                          //                                   'courier')
                          //                               .doc(shipmentId)
                          //                               .update({
                          //                               'delivered': true,
                          //                               'deliveredAt':
                          //                                   DateTime
                          //                                       .now(),
                          //                             })
                          //                           : () {};
                          //                     },
                          //                     icon: Icon(
                          //                       delivered == true
                          //                           ? CupertinoIcons
                          //                               .check_mark_circled_solid
                          //                           : CupertinoIcons
                          //                               .location_solid,
                          //                       color: delivered == true
                          //                           ? Colors.green
                          //                           : Colors.grey,
                          //                     )),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _launchWhatsapp() async {
    var whatsapp = whatsappNo;
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=$message");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }
}
