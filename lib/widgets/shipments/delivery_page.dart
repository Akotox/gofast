
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/exports/exported_widgets.dart';

class Deliveries extends StatelessWidget {
  const Deliveries({
    Key? key,
    required Stream<QuerySnapshot<Map<String, dynamic>>> deliveries,
  }) : _deliveries = deliveries, super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>> _deliveries;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 10),
        child: Container(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _deliveries,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
                return const ShipmentShimmer();

              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data?.docs.isNotEmpty == true) {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {


                      return ShipmentWidget(
                        shipmentId: snapshot.data?.docs[index]['shipmentId'],
                        category: snapshot.data?.docs[index]['category'],
                        destination: snapshot.data?.docs[index]
                        ['destination'],
                        destinationNumber: snapshot.data?.docs[index]
                        ['destinationNumber'],
                        pickupAd: snapshot.data?.docs[index]['pickupAd'],
                        pickupNumber: snapshot.data?.docs[index]
                        ['pickupNumber'],
                        sendBy: snapshot.data?.docs[index]['sendBy'],
                        weight: snapshot.data?.docs[index]['weight'],
                        pickup: snapshot.data?.docs[index]['pickup'],
                        createdAt: snapshot.data?.docs[index]['createdAt'],
                        delivered: snapshot.data?.docs[index]['delivered'],
                        accepted: snapshot.data?.docs[index]['accepted'],
                        // startLat: snapshot.data?.docs[index]['startLat'],
                        // startLng: snapshot.data?.docs[index]['startLng'],
                        // postedDate: '',
                        intransit: snapshot.data?.docs[index]['intransit'],
                        progress: snapshot.data?.docs[index]['progress'],
                      );

                    },
                  );
                } else {
                  return  const Empty();
                }
              }
              return const CircularProgressIndicator();

            },
          ),
        ));
  }
}

