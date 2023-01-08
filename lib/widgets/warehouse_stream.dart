import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/exports/exported_widgets.dart';
import 'package:gofast/widgets/warehouse.dart';

class StorageStream extends StatelessWidget {
  const StorageStream({
    Key? key,
    required Future<QuerySnapshot> warehouse,
  })  : _warehouse = warehouse,
        super(key: key);

  // final Stream<QuerySnapshot<Map<String, dynamic>>> _warehouse;
  final Future<QuerySnapshot> _warehouse;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15, 0, 10),
        child: Container(
          child: FutureBuilder<QuerySnapshot>(
            future: _warehouse,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return const ShipmentShimmer();
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data?.docs.isNotEmpty == true) {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return StorageWidget(
                        code: snapshot.data?.docs[index]['code'],
                        vicility: snapshot.data?.docs[index]['vicility'],
                        status: snapshot.data?.docs[index]['status'],
                        availabitity: snapshot.data?.docs[index]
                            ['availability'],
                        capacity: snapshot.data?.docs[index]['capacity'],
                        address: snapshot.data?.docs[index]['address'],
                      );
                    },
                  );
                } else {
                  return const Empty();
                }
              }
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}
