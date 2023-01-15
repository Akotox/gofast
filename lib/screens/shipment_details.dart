import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:intl/intl.dart';
import 'package:gofast/providers/shipment.dart';
import 'package:gofast/screens/mainscreen_courier.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ShipmentDetailsScreen extends StatefulWidget {
  const ShipmentDetailsScreen({
    Key? key,
    required this.progress,
    this.package,
  }) : super(key: key);
  final int progress;
  final QueryDocumentSnapshot<Map<String, dynamic>>? package;

  @override
  State<ShipmentDetailsScreen> createState() => _ShipmentDetailsScreenState();
}

class _ShipmentDetailsScreenState extends State<ShipmentDetailsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? scanResult;

  late String whatsappNo = "";
  late String message = "";
  String url = "";
  bool? changes;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _detailsProvider = Provider.of<ShipmentProvider>(context);
    var data = _detailsProvider.shipment;
    setState(() {
      parcelId = data?['shipmentId'];
      changes = data?['accepted'];
    });
    int activeStep = data?['progress'];
    return Scaffold(
      backgroundColor: Theme.of(context).iconTheme.color,
      appBar: AppBar(
        backgroundColor: Theme.of(context).iconTheme.color,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              AntDesign.closecircleo,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MainCourier()));
            }),
        actions: [
          munhu!.courierVerification == true && widget.package!['courierId'] == _auth.currentUser!.uid?
          IconButton(
              icon: const Icon(
                MaterialCommunityIcons.package,
                color: Colors.white,
              ),
              onPressed: () {
                pCode();
              }): const SizedBox.shrink()
        ],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8.0, left: 8, bottom: 12),
            height: changes == true
                ? MediaQuery.of(context).size.height * 0.63
                : MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Colors.white, Color(0xFF03608F)],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${data!['category']}  - ${data['weight']} kgs",
                          style:
                              textStyle(14, Colors.black54, FontWeight.bold)),
                      const SizedBox(
                        width: 10,
                      ),
                      changes == true
                          ? Row(
                              children: [
                                Text('Delivered',
                                    style: textStyle(
                                        14, Colors.black54, FontWeight.bold)),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(CupertinoIcons.check_mark_circled,
                                    size: 14, color: Colors.black54)
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    changes == true
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 14.0, bottom: 15),
                            child: Text('Parcel Delivery Details',
                                style: textStyle(
                                    14, Colors.black54, FontWeight.bold)),
                          )
                        : const SizedBox.shrink(),
                    changes == true
                        ? Container(
                            height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              image: const DecorationImage(
                                  image: AssetImage("assets/images/bg.png"),
                                  fit: BoxFit.cover,
                                  opacity: 0.54),
                              borderRadius: BorderRadius.circular(20),
                              // gradient: const LinearGradient(
                              //     colors: [Colors.white, Color(0xFF03608F)]),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18.0, top: 30, right: 18),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Courier(data: data),
                                          Time(data: data),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: EasyStepper(
                                        alignment: Alignment.center,
                                        direction: Axis.horizontal,
                                        activeStep: activeStep,
                                        enableStepTapping: false,
                                        showTitle: true,
                                        disableScroll: true,
                                        lineLength: 45,
                                        lineDotRadius: 1,
                                        lineSpace: 5,
                                        stepRadius: 20,
                                        unreachedStepIconColor:
                                            Colors.grey.shade900,
                                        unreachedStepBorderColor:
                                            Colors.grey.shade900,
                                        unreachedStepTextColor:
                                            Colors.grey.shade900,
                                        finishedStepBackgroundColor:
                                            Theme.of(context).iconTheme.color,
                                        finishedStepBorderColor:
                                            Theme.of(context).iconTheme.color,
                                        finishedStepTextColor:
                                            Theme.of(context).iconTheme.color,
                                        activeStepBorderColor:
                                            Theme.of(context).iconTheme.color,
                                        activeStepBackgroundColor:
                                            Colors.black38,
                                        activeStepTextColor:
                                            Colors.lightBlue.shade600,
                                        lineColor:
                                            Theme.of(context).iconTheme.color,
                                        padding: 8,
                                        steps: const [
                                          EasyStep(
                                            icon: Icon(MaterialCommunityIcons
                                                .bike_fast),
                                            activeIcon: Icon(
                                                MaterialCommunityIcons.cached),
                                            finishIcon:
                                                Icon(Icons.check_circle),
                                            title: 'Processing',
                                            // lineText: "12:38",
                                          ),
                                          EasyStep(
                                            icon: Icon(CupertinoIcons.cube_box),
                                            finishIcon:
                                                Icon(Icons.check_circle),
                                            title: 'Dispatch',
                                            // lineText: '3 KM',
                                          ),
                                          EasyStep(
                                            icon: Icon(MaterialCommunityIcons
                                                .bike_fast),
                                            finishIcon:
                                                Icon(Icons.check_circle),
                                            title: 'In-transit',
                                            // lineText: '3 KM',
                                          ),
                                          EasyStep(
                                            icon: Icon(
                                                MaterialIcons.location_history),
                                            finishIcon:
                                                Icon(Icons.check_circle),
                                            title: 'Drop Off',
                                            // lineText: '3 KM',
                                          ),
                                        ],
                                        onStepReached: (index) =>
                                            setState(() => activeStep = index),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: -30,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white38,
                                          backgroundImage:
                                              NetworkImage(data['image']),
                                        ),
                                      ),
                                      Container(
                                        height: 140,
                                        width: 2,
                                        decoration: const BoxDecoration(
                                            color: Colors.white54,
                                            // border: Border.all(
                                            //     width: 1, color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8, top: 35),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Slidable(
                key: const ValueKey(0),
                // The end action pane is the one at the right or the bottom side.
                endActionPane: const ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      // An action can be bigger than the others.
                      flex: 1,
                      onPressed: doNothing,
                      backgroundColor: Colors.lightBlue,
                      foregroundColor: Color(0xFFFFFFFF),
                      icon:
                          MaterialCommunityIcons.checkbox_marked_circle_outline,
                      label: 'Accept',
                    ),
                    SlidableAction(
                      onPressed: doNothing,
                      backgroundColor: Color.fromARGB(255, 3, 110, 164),
                      foregroundColor: Colors.white,
                      icon: MaterialCommunityIcons.truck_fast_outline,
                      label: 'Deliver',
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(19),
                          bottomRight: Radius.circular(19)),
                    ),
                  ],
                ),

                child: Container(
                  height: 190,
                  decoration: const BoxDecoration(
                    color: Colors.white38,
                    image: DecorationImage(
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
                                    "${data['pickupAd']}",
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
                                onTap: data['accepted'] == true
                                    ? () {
                                        setState(() {
                                          whatsappNo = data['pickupNumber'];

                                          message =
                                              "The courier is on the way to pick-up the parcel no. ${data['shipmentId']}. Are you at ${data['pickupAd']}";
                                        });
                                        _launchWhatsapp();
                                      }
                                    : () {},
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    Text(
                                      '${data['pickupNumber']}',
                                      textAlign: TextAlign.justify,
                                      style: textStyle(
                                          10, Colors.black87, FontWeight.w500),
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
                                    "${data['destination']}",
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
                                onTap: data['intransit'] == true
                                    ? () {
                                        setState(() {
                                          whatsappNo =
                                              data['destinationNumber'];
                                          message =
                                              "${data['shipmentId']} is almost at the designated location ${data['destination']}. Please confirm with a message, if you are at this location. Thank you. ";
                                        });
                                        _launchWhatsapp();
                                      }
                                    : () {},
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    Text(
                                      "${data['destinationNumber']}",
                                      textAlign: TextAlign.justify,
                                      style: textStyle(
                                          10, Colors.black87, FontWeight.w500),
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
                        munhu!.courierVerification != false
                            ? InkWell(
                                onLongPress: () {
                                  data['delivered'] != true
                                      ? qrMethod()
                                      : () {};
                                },
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.14,
                                  width:
                                      MediaQuery.of(context).size.width * 0.28,
                                  child: BarcodeWidget(
                                    data:
                                        "${data['progress']}${data['shipmentId']} parcel",
                                    barcode: Barcode.qrCode(),
                                    drawText: false,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    backgroundColor: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.14,
                                width: MediaQuery.of(context).size.width * 0.28,
                                child: BarcodeWidget(
                                  data: "${data['shipmentId']} search",
                                  barcode: Barcode.qrCode(),
                                  drawText: false,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
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
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> qrMethod() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black87,
        context: context,
        builder: (context) {
          String? buttontxt;
          if (widget.package!['progress'] == 0) {
            buttontxt = "accept this job";
          } else if (widget.package!['progress'] == 1) {
            buttontxt = "pick-up parcel";
          } else if (widget.package!['progress'] == 2) {
            buttontxt = "Start Delivering";
          } else if (widget.package!['progress'] == 3) {
            buttontxt = "Drop - off";
          } else if (widget.package!['progress'] == 4) {
            buttontxt = "Delivered";
          }

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 80),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/images/bg2.png"),
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

                                      if (widget.progress == 0) {
                                        FirebaseFirestore.instance
                                            .collection('courier')
                                            .doc(parcelId)
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
                                          'progress': widget.progress + 1,
                                        });
                                        setState(() {
                                          changes == true;
                                        });
                                        Future.delayed(const Duration(
                                                microseconds: 2000))
                                            .then((value) =>
                                                Navigator.pop(context));
                                      } else if (widget.progress == 1) {
                                        FirebaseFirestore.instance
                                            .collection('courier')
                                            .doc(parcelId)
                                            .update({
                                          'update': update,
                                          'pickup': true,
                                          'pickedAt': date,
                                          'progress': widget.progress + 1,
                                        });
                                        Future.delayed(const Duration(
                                                microseconds: 2000))
                                            .then((value) =>
                                                Navigator.pop(context));
                                      } else if (widget.progress == 2) {
                                        FirebaseFirestore.instance
                                            .collection('courier')
                                            .doc(parcelId)
                                            .update({
                                          'update': update,
                                          'intransit': true,
                                          'intransit_time': date,
                                          'progress': widget.progress + 1,
                                        });
                                        Future.delayed(const Duration(
                                                microseconds: 2000))
                                            .then((value) =>
                                                Navigator.pop(context));
                                      } else if (widget.progress == 3) {
                                        FirebaseFirestore.instance
                                            .collection('courier')
                                            .doc(parcelId)
                                            .update({
                                          'update': update,
                                          'deliveredAt': date,
                                          'delivered': true,
                                          'progress': widget.progress + 1,
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

  Future<dynamic> pCode() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black87,
        context: context,
        builder: (context) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 80),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/images/bg2.png"),
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
                                "Parcel Code",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${widget.package!['shipmentId']}"
                                    .toUpperCase(),
                                style: Theme.of(context).textTheme.headline3,
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

class Courier extends StatelessWidget {
  const Courier({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DocumentSnapshot<Object?>? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  MaterialCommunityIcons.clock,
                  size: 13,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Pick-Up Time :',
                  style: textStyle(10, Colors.black, FontWeight.w800),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 18, top: 3),
              child: Text(
                "${data?['pickedAt']}",
                textAlign: TextAlign.justify,
                style: textStyle(10, Colors.black87, FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  MaterialCommunityIcons.bike_fast,
                  size: 13,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Dispatch Time :',
                  style: textStyle(10, Colors.black, FontWeight.w800),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 18, top: 3),
                child: data?['delivered'] != false
                    ? Text(
                        "${data?['intransit_time']}",
                        textAlign: TextAlign.justify,
                        style: textStyle(10, Colors.black87, FontWeight.w600),
                      )
                    : Text(
                        "......",
                        textAlign: TextAlign.justify,
                        style: textStyle(10, Colors.black87, FontWeight.w600),
                      )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  MaterialCommunityIcons.flag,
                  size: 13,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Delivery Time :',
                  style: textStyle(10, Colors.black, FontWeight.w800),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 18, top: 3),
                child: data?['delivered'] != false
                    ? Text(
                        "${data?['deliveredAt']}",
                        textAlign: TextAlign.justify,
                        style: textStyle(10, Colors.black87, FontWeight.w600),
                      )
                    : Text(
                        "......",
                        textAlign: TextAlign.justify,
                        style: textStyle(10, Colors.black87, FontWeight.w600),
                      )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }
}

class Time extends StatelessWidget {
  const Time({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DocumentSnapshot<Object?>? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  MaterialCommunityIcons.office_building_outline,
                  size: 13,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Company',
                  style: textStyle(10, Colors.black, FontWeight.w800),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 18, top: 3),
              child: Text(
                "${data?['company']}".toUpperCase(),
                textAlign: TextAlign.justify,
                style: textStyle(10, Colors.black87, FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  MaterialCommunityIcons.truck_fast_outline,
                  size: 13,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'License No.',
                  style: textStyle(10, Colors.black, FontWeight.w800),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 18, top: 3),
              child: Text(
                "${data?['vehicle']}",
                textAlign: TextAlign.justify,
                style: textStyle(10, Colors.black87, FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Ionicons.phone_portrait_outline,
                  size: 13,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Phone',
                  style: textStyle(10, Colors.black, FontWeight.w800),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 18, top: 3),
              child: Text(
                "${data?['courierNumber']}",
                textAlign: TextAlign.justify,
                style: textStyle(10, Colors.black87, FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }
}

void doNothing(BuildContext context) {
  FirebaseFirestore.instance.collection('courier').doc(parcelId).update({
    'courierId': FirebaseAuth.instance.currentUser!.uid,
    'courierNumber': munhu!.phoneNumber,
    'vehicle': "plate",
    'company': "company",
    'accepted': true,
    'progress': 1,
  });
}
