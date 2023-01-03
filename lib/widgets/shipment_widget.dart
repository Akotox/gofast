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
  final double progress;
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
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
              height: MediaQuery.of(context).size.height * 0.19,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          widget.pickup == false
                              ? Row(
                                  children: [
                                    Text(
                                      'Processing',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.cached,
                                      size: 10,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          widget.pickup == true && widget.accepted == true
                              ? Row(
                                  children: [
                                    Text(
                                      'Accepted',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.check_circle,
                                      size: 10,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            width: 5,
                          ),
                          widget.pickup == true &&
                                  widget.accepted == true &&
                                  widget.intransit == true
                              ? Row(
                                  children: [
                                    Text(
                                      'In-transit',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.check_circle,
                                      size: 10,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            width: 5,
                          ),
                          widget.pickup == true &&
                                  widget.accepted == true &&
                                  widget.intransit == true &&
                                  widget.delivered == true
                              ? Row(
                                  children: [
                                    Text(
                                      'Delivered',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.check_circle,
                                      size: 10,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Last updated : $lastUpdateTime",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
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
                            Icons.location_on_outlined,
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
                      const SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        height: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: LinearProgressIndicator(
                            value: widget.progress,
                            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                            backgroundColor: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
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
                          child: Row(
                            children: [
                              Text('Details',
                                  style: Theme.of(context).textTheme.bodyText2),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 10,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.sendBy == _auth.currentUser!.uid
                ? const Positioned(
                    right: 10,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(
                        MaterialCommunityIcons.cube_send
                      ),
                    ))
                : const SizedBox.shrink(),
            widget.destinationNumber == phoneNumber
                ? const Positioned(
                    right: 10,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(MaterialCommunityIcons.cube_send,
                          color: Colors.black),
                    ))
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  _deleteDialog() {
    User? user = _auth.currentUser;
    final uid = user!.uid;
    showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            backgroundColor: Colors.white,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                      const Icon(
                        Icons.warning_outlined,
                        size: 28,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Do you want to delete?'.toUpperCase(),
                        style: textStyle(22, Colors.black, FontWeight.w500),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: Colors.red,
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
                              Navigator.canPop(ctx) ? Navigator.pop(ctx) : null;
                            } else {
                              GlobalMethod.showErrorDialog(
                                  error: 'You cannot perform this action',
                                  ctx: ctx);
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
                            color: Colors.red,
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
                        color: Colors.green,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 2,
                            color: Colors.green,
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
          );
        });
  }
}
