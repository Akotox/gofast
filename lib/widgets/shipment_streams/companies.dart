import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/exports/exported_widgets.dart';
import 'package:gofast/widgets/companies.dart';
import 'package:gofast/widgets/courier_streams/job.dart';
import 'package:gofast/widgets/warehouse.dart';

class CompaniesBuilda extends StatelessWidget {
  const CompaniesBuilda({
    Key? key,
    required Stream<QuerySnapshot<Map<String, dynamic>>> couriers,
  })  : _couriers = couriers,
        super(key: key);
  final Stream<QuerySnapshot<Map<String, dynamic>>> _couriers;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _couriers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return const ShipmentShimmer();
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data?.docs.isNotEmpty == true) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data?.docs[index];
                // var selectedIndex = index;
                return Company(
                 
                );
              },
            );
          } else {
            return const Empty();
          }
        }
        return const ErrorWid();
      },
    );
  }
}


