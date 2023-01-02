import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lottie/lottie.dart';

class OutGoing extends StatefulWidget {
  const OutGoing({super.key});

  @override
  State<OutGoing> createState() => _OutGoingState();
}

class _OutGoingState extends State<OutGoing> with TickerProviderStateMixin {
  late TabController _tabController = TabController(
    length: 4,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        children: [
          content(),
          sendingTab(tabController: _tabController),
        ],
      ),
    );
  }

  Widget content() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).iconTheme.color,
        image: const DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
            opacity: 0.45),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Lottie.asset('assets/json/delivery.json',
                      width: 50, height: 50),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "OutGoing Parcels",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 49,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              AntDesign.search1,
                              color: Color(0xFF03608F),
                            ),
                            hintText:
                                "Search Using Parcel Number or Scan the QRCode",
                            hintStyle: Theme.of(context).textTheme.headline6,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 50,
                        height: 49,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: const Icon(MaterialCommunityIcons.qrcode_scan),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(MaterialCommunityIcons.cube_send),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Send Parcel'.toUpperCase(),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            MaterialCommunityIcons.barcode,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Collection ID'.toUpperCase(),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(MaterialCommunityIcons.bike_fast),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Pick Up Parcel'.toUpperCase(),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class sendingTab extends StatelessWidget {
  const sendingTab({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey[300]),
                child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Color(0xFF03608F),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelColor: Colors.white,
                    labelStyle: Theme.of(context).textTheme.headline4,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: "Dispatch",
                      ),
                      Tab(
                        text: "Picked",
                      ),
                      Tab(
                        text: "Intransit",
                      ),
                      Tab(
                        text: "Delivered",
                      )
                    ]),
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 10, 20, 10),
                          child: Container(
                            child: Text("Welcome"),
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 10, 12, 10),
                        child: Text(
                          "widget.content",
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 10, 12, 10),
                        child: Text(
                          "widget.content",
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 10, 12, 10),
                        child: Text(
                          "widget.content",
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
