import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DeliveryWigdet extends StatefulWidget {
  static const String id = 'deliveries';

  const DeliveryWigdet({Key? key}) : super(key: key);

  @override
  State<DeliveryWigdet> createState() => _DeliveryWigdetState();
}

class _DeliveryWigdetState extends State<DeliveryWigdet> {
  String? category;
  // final FirebaseAuth auth = FirebaseAuth.instance;


  @override
 
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Text("Incoming", style: Theme.of(context).textTheme.headline4),
              SizedBox(
                width: 10,
              ),
              Text("OutGoing", style: Theme.of(context).textTheme.headline4),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: TabBar(
              indicatorWeight: 2,
              unselectedLabelColor: Colors.grey.shade600,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              labelPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),

              labelStyle: Theme.of(context).textTheme.headline4,
              labelColor: Color(0xFF03608F),
              indicatorPadding: EdgeInsets.only(left: 20, right: 20),
              indicatorColor: Color(0xFF03608F),
              // indicator: CircleTabIndicator(color: Colors.green, radius: 4),
              tabs: const [
                Tab(
                  text: ('Dispatch'),
                ),
                Tab(
                  text: ('Picked'),
                ),
                Tab(
                  text: ('In transit'),
                ),
                Tab(
                  text: ('Delivered'),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFE0DFDF),
                      image: DecorationImage(
                          image: AssetImage("assets/images/bg.png"),
                          fit: BoxFit.cover,
                          opacity: 0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50,
                  color: Colors.blue,
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50,
                  color: Colors.blue,
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShipmentShimmer extends StatelessWidget {
  const ShipmentShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade600,
      highlightColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).indicatorColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Parcels extends StatelessWidget {
  const Parcels({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.height * 0.15,
            child: Image.asset('assets/images/empty.png')),
        Text(
          "You don\'t have parcels yet",
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
