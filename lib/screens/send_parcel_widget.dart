import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/services/firebase_services.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

class Steppa extends StatefulWidget {
  const Steppa({super.key});

  @override
  State<Steppa> createState() => _SteppaState();
}

class _SteppaState extends State<Steppa> {
  final _formKey = GlobalKey<FormState>();

  FirebaseServices _service = FirebaseServices();
  final _sndformKey = GlobalKey<FormState>();
  final TextEditingController _pickUpAddress = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _destination = TextEditingController();
  final TextEditingController _destinationNumber = TextEditingController();
  late Stream<QuerySnapshot<Map<String, dynamic>>> _couriers;
  late Future<DocumentSnapshot<Map<String, dynamic>>> _getCompanies;
  // late Future<DocumentSnapshot<Map<String, dynamic>>> _getSizes;

  final CollectionReference companiesCol =
      FirebaseFirestore.instance.collection('company');

  bool _isLoading = false;

  int _counter = 0;

  void increment() {
    setState(() {
      _counter++;
    });
  }

  void decrement() {
    setState(() {
      _counter--;
    });
  }

  @override
  void didChangeDependencies() {
    _getCompanies =
        FirebaseFirestore.instance.collection('company').doc(companyid).get();
    // _getSizes =
    // FirebaseFirestore.instance.collection('company').doc(companyid).get();
    super.didChangeDependencies();

    _couriers = FirebaseFirestore.instance.collection('company').snapshots();
  }

  String productCategory = 'GoFasta';

  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
          title: 'Please the Courier Service Provider',
          subtitle:
              'Choose a provider or the system automatically pick for you',
          content: SingleChildScrollView(
              child: FutureBuilder<DocumentSnapshot>(
                  future: _getCompanies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Lottie.asset("assets/json/delivery.json"));
                    } else {
                      if (snapshot.data == null) {
                        const Center(
                          child: Text('No companies available'),
                        );
                      }
                    }
                    var companies = snapshot.data!['companies'];
                    // print(companies!['companies'][0]['name']);
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 16,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Theme.of(context).backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).shadowColor,
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              companies![index]['image']),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${companies![index]['name']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "${companies![index]['hours']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "${companies![index]['hq']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Radio(
                                  activeColor: Theme.of(context)
                                      .progressIndicatorTheme
                                      .color,
                                  value: "${companies![index]['name']}",
                                  groupValue: productCategory,
                                  onChanged: (value) {
                                    setState(() {
                                      productCategory = value.toString();
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: snapshot.data!['companies'].length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            thickness: 0,
                            indent: 0,
                            color: Colors.transparent,
                          );
                        });
                  })),
          validation: () {
            return null;
          }),
      CoolStep(
        title: 'Please select a Category',
        subtitle: 'Choose a category type of your parcel',
        content: SingleChildScrollView(
            child: FutureBuilder<DocumentSnapshot>(
                future: _getCompanies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Lottie.asset("assets/json/delivery.json"));
                  } else {
                    if (snapshot.data == null) {
                      const Center(
                        child: Text('No companies available'),
                      );
                    }
                  }
                  var companies = snapshot.data!['sizes'];
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return index != 4
                            ? Container(
                                margin: const EdgeInsets.only(
                                  bottom: 16,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                height: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(19),
                                  color: Theme.of(context).backgroundColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).shadowColor,
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          activeColor: Theme.of(context)
                                              .progressIndicatorTheme
                                              .color,
                                          value: "${companies![index]['name']}",
                                          groupValue: productCategory,
                                          onChanged: (value) {
                                            setState(() {
                                              productCategory =
                                                  value.toString();
                                            });
                                          },
                                        ),

                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            image: DecorationImage(
                                              image: AssetImage(type[index]),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${companies![index]['name']}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                              child: Text(
                                                "${companies![index]['condition']}",
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                          ],
                                        ),
                                        //  const SizedBox(
                                        //   width: 13,
                                        // ),
                                        companies![index]['name'] ==
                                                productCategory
                                            ? Row(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        decrement();
                                                      },
                                                      child: const Icon(
                                                        CupertinoIcons
                                                            .minus_circle,
                                                        color: Colors.grey,
                                                      )),
                                                  Container(
                                                    width: 30,
                                                    child: Center(
                                                        child: Text("$_counter",
                                                            style: textStyle(
                                                                16,
                                                                Colors.black87,
                                                                FontWeight
                                                                    .w700))),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        increment();
                                                      },
                                                      child: const Icon(
                                                          CupertinoIcons
                                                              .plus_circle,
                                                          color: Colors.grey)),
                                                ],
                                              )
                                            : SizedBox.shrink()
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                color: Colors.black,
                                height: 10,
                                width: 30,
                              );
                      },
                      itemCount: snapshot.data!['sizes'].length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 0,
                          indent: 0,
                          color: Colors.transparent,
                        );
                      });
                })),
        validation: () {
          return null;
        },
      ),
      CoolStep(
        title: 'Sender Information',
        subtitle: 'Please fill the required information to get started',
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                labelText: 'Pick-up address',
                hintText: "00 Marlborough, Harare, Zimbabwe",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Pick-up address is required';
                  }
                  return null;
                },
                controller: _pickUpAddress,
              ),
              _buildTextField(
                labelText: 'Phone Number',
                hintText: "+263000000000",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone number is required ';
                  }
                  return null;
                },
                controller: _phoneNumber,
              ),

              productCategory == "Custom" ?
              _buildTextField(
                labelText: 'Pacel Details',
                hintText: "Tikuda kutama ",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Details are required';
                  }
                  return null;
                },
                controller: _phoneNumber,
              ):SizedBox.fromSize()
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'Reciever Information',
        subtitle: 'Please fill the required information to proceed',
        content: Form(
          key: _sndformKey,
          child: Column(
            children: [
              _buildTextField(
                labelText: 'Drop-off address',
                hintText: "00 Marlborough, Harare, Zimbabwe ",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Drop-off address is required';
                  }
                  return null;
                },
                controller: _destination,
              ),
              _buildTextField(
                labelText: 'Phone Number',
                hintText: "+263000000000",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone number is required ';
                  }
                  return null;
                },
                controller: _destinationNumber,
              ),
            ],
          ),
        ),
        validation: () {
          if (!_sndformKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
    ];

    final stepper = CoolStepper(
      showErrorSnackbar: false,
      onCompleted: () {
        _uploadShipment();
      },
      steps: steps,
      config: const CoolStepperConfig(
        backText: 'BACK',
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          stepper,
          Positioned(
            top: 35,
            left: 10,
            child: Row(
              children: [
                IconButton(
                    icon: const Icon(
                      AntDesign.closecircleo,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Text('Welcome to our Courier Center'.toUpperCase(),
                    style: textStyle(14, Colors.white, FontWeight.bold))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField({
    String? labelText,
    FormFieldValidator<String>? validator,
    TextEditingController? controller,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        cursorColor: Colors.black,
        cursorHeight: 15,
        cursorRadius: Radius.circular(15),
        cursorWidth: 1,
        style: textStyle(14, Colors.black, FontWeight.w500),
        decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.headline5,
            labelText: labelText,
            hintText: hintText,
            hintStyle: textStyle(12, Colors.black54, FontWeight.normal)),
        validator: validator,
        controller: controller,
      ),
    );
  }

  void _uploadShipment() async {
    final shipmentId = const Uuid().v4();
    User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    final isValid = _formKey.currentState!.validate() &&
        _sndformKey.currentState!.validate();
    // double? startLat;
    // double? startLng;
    // double? endLat;
    // double? endLng;

    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        // List<Location> location = await locationFromAddress(_pickupController.text);
        // setState((){
        //   startLat = location[0].latitude;
        //   startLng = location[0].longitude;
        // });
        // List<Location> endLocation = await locationFromAddress(_receiverController.text);
        // setState((){
        //   endLat = endLocation[0].latitude;
        //   endLng = endLocation[0].longitude;
        // });
        await FirebaseFirestore.instance
            .collection('courier')
            .doc(shipmentId)
            .set({
          'shipmentId': shipmentId,
          'sendBy': uid,
          'pickupAd': _pickUpAddress.text,
          'pickupNumber': _phoneNumber.text,
          'destination': _destination.text,
          'category': productCategory,
          'destinationNumber': _destinationNumber.text,
          'pickup': false,
          'delivered': false,
          'accepted': false,
          'intransit': false,
          'progress': 0,
          'weight': _counter.toString(),
          'createdAt': DateTime.now().microsecondsSinceEpoch,
          'pickedAt': null,
          'intransitAt': null,
          'intransit_time': null,
          'deliveredAt': null,
          'courierId': null,
          'courierNumber': null,
          'vehicle': null,
          // 'startLat': startLat,
          // 'startLng': startLng,
          // 'endLat': endLat,
          // 'endLng': endLng,
        });
        await Fluttertoast.showToast(
          msg: "Your shipment has been uploaded",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.green,
          fontSize: 16,
        );
        _destination.clear();
        _destinationNumber.clear();
        _phoneNumber.clear();
        _pickUpAddress.clear();
        setState(() {
          _counter = 0;
          productCategory = 'Others';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('It is not valid');
    }
  }

  @override
  void dispose() {
    _pickUpAddress.dispose();
    _phoneNumber.dispose();
    _destinationNumber.dispose();

    super.dispose();
  }
}
