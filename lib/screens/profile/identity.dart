import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/global/global_variables.dart';
import 'package:gofast/providers/shipment.dart';
import 'package:provider/provider.dart';

class Identity extends StatelessWidget {
  const Identity({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<ShipmentProvider>(context).thisUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              AntDesign.closecircleo,
              color: Colors.lightBlue,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.661,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/images/extended.png"),
                      fit: BoxFit.cover,
                      opacity: 0.45),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(19),
                      ),
                  color: Colors.lightBlue.shade600),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 5,
                    width: 40,
                    decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(19),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFFFFFFF),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          const SizedBox(
                            height: 50,
                            width: 50,
                            child: CircleAvatar(
                              backgroundColor: Colors.white38,
                              backgroundImage:
                                  AssetImage("assets/images/user.png"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Stack(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(
                                      right: 30, left: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text(
                                    "${user!['name']}",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  )),
                              const Positioned(
                                right: 0,
                                child: Icon(AntDesign.checkcircle, size: 20),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: BarcodeWidget(
                                  data: "${user['phoneNumber']}.${user['name']}",
                                  barcode: Barcode.code128(),
                                  drawText: false,
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 4, top: 10),
                                  backgroundColor: Colors.black,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                              Text(
                                "This barcode is used to verify your identity before parcel collection.",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
       ,
      ),
    );
  }
}