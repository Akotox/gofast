import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/exports/exported_widgets.dart';

class Picked extends StatelessWidget {
  const Picked({
    Key? key,
    required Stream<QuerySnapshot<Map<String, dynamic>>> picked,
  })  : _picked = picked,
        super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>> _picked;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15, 0, 10),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _picked,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return const ShipmentShimmer();
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data?.docs.isNotEmpty == true) {
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var package = snapshot.data?.docs[index];

                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, right: 8, left: 8),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(19)),
                        child: ShipmentWidget(
                          package: package,
                          shipmentId: snapshot.data?.docs[index]
                              ['shipmentId'],
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
                          createdAt: snapshot.data?.docs[index]
                              ['createdAt'],
                          delivered: snapshot.data?.docs[index]
                              ['delivered'],
                          accepted: snapshot.data?.docs[index]['accepted'],
                          // startLat: snapshot.data?.docs[index]['startLat'],
                          // startLng: snapshot.data?.docs[index]['startLng'],
                          // postedDate: '',
                          intransit: snapshot.data?.docs[index]
                              ['intransit'],
                          progress: snapshot.data?.docs[index]['progress'],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Empty();
              }
            }
            return const ErrorWid();
          },
        ));
  }
}

class ErrorWid extends StatelessWidget {
  const ErrorWid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/images/digi.png'),
    );
  }
}
