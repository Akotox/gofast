import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/screens/courier.dart';
import 'package:gofast/screens/mainscreen_courier.dart';
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
  int activeStep = 1;

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
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MainCourier()));
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin:
                      const EdgeInsets.only(right: 8.0, left: 8, bottom: 12),
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                        colors: [Colors.white, Color(0xFF03608F)]),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
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
                      EasyStepper(
                        alignment: Alignment.centerLeft,
                        direction: Axis.vertical,
                        activeStep: activeStep,
                        enableStepTapping: false,
                        showTitle: true,
                        disableScroll: true,
                        lineLength: 40,
                        lineDotRadius: 1,
                        lineSpace: 5,
                        stepRadius: 20,
                        unreachedStepIconColor: Colors.black38,
                        unreachedStepBorderColor: Colors.black38,
                        unreachedStepTextColor: Colors.black38,
                        finishedStepBackgroundColor:
                            Theme.of(context).iconTheme.color,
                        finishedStepBorderColor:
                            Theme.of(context).iconTheme.color,
                        finishedStepTextColor:
                            Theme.of(context).iconTheme.color,
                        activeStepBorderColor:
                            Theme.of(context).iconTheme.color,
                        lineColor: Theme.of(context).iconTheme.color,
                        padding: 8,
                        steps: const [
                          EasyStep(
                            icon: Icon(MaterialCommunityIcons.bike_fast),
                            activeIcon: Icon(MaterialCommunityIcons.cached),
                            finishIcon: Icon(Icons.check_circle),
                            title: 'Processing',
                            lineText: '1.7 KM',
                          ),
                          EasyStep(
                            icon: Icon(CupertinoIcons.cube_box),
                            finishIcon: Icon(Icons.check_circle),
                            title: 'Dispatch',
                            lineText: '3 KM',
                          ),
                          EasyStep(
                            icon: Icon(MaterialCommunityIcons.bike_fast),
                            finishIcon: Icon(Icons.check_circle),
                            title: 'In-transit',
                            lineText: '3 KM',
                          ),
                          EasyStep(
                            icon: Icon(MaterialIcons.location_history),
                            finishIcon: Icon(Icons.check_circle),
                            title: 'Drop Off',
                            lineText: '3 KM',
                          ),
                        ],
                        onStepReached: (index) =>
                            setState(() => activeStep = index),
                      ),
                    ],
                  ),
                ),
                Details(
                    pickupAd: pickupAd,
                    pickupNumber: pickupNumber,
                    destination: destination,
                    destinationNumber: destinationNumber,
                    shipmentId: shipmentId),
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

class Details extends StatelessWidget {
  const Details({
    Key? key,
    required this.pickupAd,
    required this.pickupNumber,
    required this.destination,
    required this.destinationNumber,
    required this.shipmentId,
  }) : super(key: key);

  final String? pickupAd;
  final String? pickupNumber;
  final String? destination;
  final String? destinationNumber;
  final String? shipmentId;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                          style: textStyle(10, Colors.black, FontWeight.w800),
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
                          style: textStyle(10, Colors.black87, FontWeight.w500),
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
                          style: textStyle(10, Colors.black, FontWeight.w800),
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
                            pickupNumber == null ? '' : pickupNumber!,
                            textAlign: TextAlign.justify,
                            style:
                                textStyle(10, Colors.black87, FontWeight.w500),
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
                          style: textStyle(10, Colors.black, FontWeight.w800),
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
                          style: textStyle(10, Colors.black87, FontWeight.w500),
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
                          style: textStyle(10, Colors.black, FontWeight.w800),
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
                            destinationNumber == null ? '' : destinationNumber!,
                            textAlign: TextAlign.justify,
                            style:
                                textStyle(10, Colors.black87, FontWeight.w500),
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
                  padding: const EdgeInsets.only(left: 10, right: 10),
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
    );
  }
}
