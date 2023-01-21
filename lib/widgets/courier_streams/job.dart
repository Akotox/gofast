import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gofast/exports/exported_widgets.dart';

class Jobs extends StatelessWidget {
  const Jobs({
    Key? key,
    required Stream<QuerySnapshot<Map<String, dynamic>>> jobStream,
  })  : _jobStream = jobStream,
        super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>> _jobStream;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15, 0, 10),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _jobStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return const ShipmentShimmer();
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data?.docs.isNotEmpty == true) {
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var package = snapshot.data?.docs[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom:8.0, right: 8, left: 8),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(19)),
                        child: ShipmentWidget(
                          package: package,
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


