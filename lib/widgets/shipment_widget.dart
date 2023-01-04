import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/global/global_methods.dart';
import 'package:gofast/global/global_variables.dart';
import 'package:gofast/screens/shipment_details.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_stepper/easy_stepper.dart';


class ShipmentWidget extends StatefulWidget {
  final String shipmentId;
  final String category;
  final String destination;
  final String destinationNumber;
  final String pickupAd;
  final String pickupNumber;
  final String sendBy;
  final String weight;
  // final String postedDate;
  final int progress;
  final bool pickup;
  final bool intransit;
  final bool delivered;
  final bool accepted;
  final int createdAt;
  // final double startLat;
  // final double startLng;

  const ShipmentWidget({
    super.key,
    required this.shipmentId,
    required this.category,
    required this.destination,
    required this.destinationNumber,
    required this.pickupAd,
    required this.pickupNumber,
    required this.weight,
    required this.pickup,
    required this.createdAt,
    required this.sendBy,
    required this.delivered,
    required this.accepted,
    // required this.postedDate,
    required this.progress,
    required this.intransit,
    // required this.startLat,
    // required this.startLng,
  });

  @override
  State<ShipmentWidget> createState() => _ShipmentWidgetState();
}

class _ShipmentWidgetState extends State<ShipmentWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
    

  @override
  Widget build(BuildContext context) {
    int activeStep = widget.progress;
    var updateTime = DateFormat.yMMMd()
        .format(DateTime.fromMicrosecondsSinceEpoch(widget.createdAt));
    var _today = DateFormat.yMMMd().format(DateTime.fromMicrosecondsSinceEpoch(
        DateTime.now().microsecondsSinceEpoch));

    String lastUpdateTime;
    //04.04.93

    if (updateTime == _today) {
      lastUpdateTime = DateFormat('M/d @ hh:mm')
          .format(DateTime.fromMicrosecondsSinceEpoch(widget.createdAt));
      //  10:56
    } else {
      lastUpdateTime = updateTime.toString();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: InkWell(
        onLongPress: () {
          widget.pickup == false ? _deleteDialog() : () {};
        },
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ShipmentDetailsScreen(
                        pickupAd: widget.pickupAd,
                        shipmentId: widget.shipmentId,
                        destination: widget.destination,
                        weight: widget.weight,
                      )));
        },
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.21,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                    image: AssetImage("assets/images/dbg.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.5),
                color: widget.destinationNumber == phoneNumber
                    ? Theme.of(context).backgroundColor
                    : Theme.of(context).backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.shipmentId,
                          style: Theme.of(context).textTheme.headline5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  EasyStepper(
                  alignment: Alignment.center,
                  activeStep: activeStep,
                  enableStepTapping: false,
                  showTitle: true,
                  disableScroll: true,
                  lineLength: 45,
                  lineDotRadius: 1,
                  lineSpace: 3,
                  stepRadius: 20,
                  unreachedStepIconColor: Colors.black38,
                  unreachedStepBorderColor: Colors.black38,
                  unreachedStepTextColor: Colors.black38,
                  finishedStepBackgroundColor: Theme.of(context).iconTheme.color,
                  finishedStepBorderColor: Theme.of(context).iconTheme.color,
                  finishedStepTextColor: Theme.of(context).iconTheme.color,
                  activeStepBorderColor: Theme.of(context).iconTheme.color,

                  lineColor:Theme.of(context).iconTheme.color ,
                  padding: 8,
                  steps: const [
                    EasyStep(
                      icon: Icon(MaterialCommunityIcons.bike_fast),
                      activeIcon: Icon(MaterialCommunityIcons.cached),
                      finishIcon: Icon(Icons.check_circle),
                      title: 'Processing',
                      // lineText: '1.7 KM',
                    ),
                    EasyStep(
                      icon: Icon(CupertinoIcons.cube_box),
                      finishIcon: Icon(Icons.check_circle),
                      title: 'Dispatch',
                      // lineText: '3 KM',
                    ),
                    EasyStep(
                      icon: Icon(MaterialCommunityIcons.bike_fast),
                      finishIcon: Icon(Icons.check_circle),
                      title: 'In-transit',
                    ),
                    EasyStep(
                      icon: Icon(MaterialIcons.location_history),
                      finishIcon: Icon(Icons.check_circle),
                      title: 'Drop Off',
                    ),
                  ],
                  onStepReached: (index) => setState(() => activeStep = index),
                                ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Row(
                        children: [
                          const Icon(
                            AntDesign.clockcircleo,
                            size: 10,
                            
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Last updated : $lastUpdateTime",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MaterialIcons.location_history,
                            size: 10,
                            
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.pickupAd,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MaterialIcons.location_history,
                            size: 10,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.destination,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                  
                ],
              ),
            ),
            widget.sendBy == _auth.currentUser!.uid
                ? const Positioned(
                    right: 10,
                    top:5,
                    child: Icon(
                      MaterialCommunityIcons.cube_send
                    ))
                : const SizedBox.shrink(),
            widget.destinationNumber == phoneNumber
                ? const Positioned(
                    right: 10,
                    bottom: 5,
                    child: Icon(MaterialCommunityIcons.truck_fast_outline,
                         size: 20,))
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  _deleteDialog() {
    User? user = _auth.currentUser;
    final uid = user!.uid;
    showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 58),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/bg.png"),
                                fit: BoxFit.cover,
                                opacity: 0.3),
                              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                               const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Icon(
                        AntDesign.delete,
                        size: 30,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Deleting this parcel can not be reverted.\nDo you want to proceed?',
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        // color: Colors.white,
                        onPressed: () async {
                          try {
                            if (widget.sendBy == uid) {
                              await FirebaseFirestore.instance
                                  .collection('courier')
                                  .doc(widget.shipmentId)
                                  .delete();
                              await Fluttertoast.showToast(
                                msg: 'Shipment has been deleted',
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.white54,
                                fontSize: 16,
                              );
                              // Navigator.canPop(ctx) ? Navigator.pop(ctx) : null;
                            } 
                          } catch (error) {
                            GlobalMethod.showErrorDialog(
                                error: 'This job can\'t be deleted',
                                ctx: context);
                          } finally {}
                        },
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 2,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(' DELETE ',
                            style:
                                textStyle(12, Colors.white, FontWeight.w700)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      MaterialButton(
                        // color: Colors.green,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(' CANCEL ',
                            style:
                                textStyle(12, Colors.white, FontWeight.w700)),
                      ),
                    ],
                  ),
                )
              
                            ],
                          ),
                        ),
                      );
                    });
  }
}
