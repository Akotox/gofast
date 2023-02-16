// import 'dart:convert'
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gofast/algorithm/logic.dart';
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
  final FirebaseAuth auth = FirebaseAuth.instance;

  final _sndformKey = GlobalKey<FormState>();
  final TextEditingController _pickUpAddress = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _destination = TextEditingController();
  final TextEditingController _destinationNumber = TextEditingController();
  final TextEditingController _parcel = TextEditingController();
  final TextEditingController _countertxt = TextEditingController();

  late Stream<QuerySnapshot<Map<String, dynamic>>> _couriers;
  late Future<DocumentSnapshot<Map<String, dynamic>>> _getCompanies;
  final business = GetStorage();
  Payment? _payment = Payment.innbucks;

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
    if (_counter >= 1) {
      setState(() {
        _counter--;
      });
    } else {
      _counter == 0 + 1;
    }
  }

  @override
  void didChangeDependencies() {
    _getCompanies =
        FirebaseFirestore.instance.collection('company').doc(companyid).get();
    super.didChangeDependencies();
  }

  String company = 'GoFasta';
  String size = 'Small';
  String? _chosenValue;
  String? _chosenType;

  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
          title: 'Please the Courier Service Provider',
          subtitle:
              'Choose a provider or the system automatically pick for you',
          content: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _chosenValue,
                  dropdownColor: Colors.white,
                  elevation: 0,
                  style: textStyle(12, Colors.black, FontWeight.w700),
                  underline: const SizedBox.shrink(),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  items: <String>[
                    '1 Hour',
                    '3 Hour',
                    '6 Hour',
                    '12 Hour',
                    '24 Hour',
                    '48 Hour',
                    '72 Hour',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text(
                    "Please choose the delivery period",
                    style: textStyle(14, Colors.black, FontWeight.bold),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _chosenValue = value;
                      print(_chosenValue);
                    });
                  },
                ),
              ),
              FutureBuilder<DocumentSnapshot>(
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
                            // margin: const EdgeInsets.only(
                            //   bottom: 8,
                            // ),
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
                                  groupValue: company,
                                  onChanged: (value) {
                                    setState(() {
                                      company = value.toString();
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
                  }),
            ],
          )),
          validation: () {
            return null;
          }),
      CoolStep(
        title: 'Please select a Category',
        subtitle: 'Choose a category type of your parcel',
        content: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: _chosenType,
                dropdownColor: Colors.white,
                elevation: 0,
                style: textStyle(12, Colors.black, FontWeight.w700),
                underline: const SizedBox.shrink(),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                items: <String>[
                  'Documents',
                  'Electronics',
                  'Perishables',
                  'Non Perishables',
                  'Liquids',
                  'Flamables',
                  'Bulk',
                  'Fragile',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text(
                  "Please choose product type",
                  style: textStyle(14, Colors.black, FontWeight.bold),
                ),
                onChanged: (value) {
                  setState(() {
                    _chosenType = value;
                  });
                },
              ),
            ),
            
            FutureBuilder<DocumentSnapshot>(
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
                        return Container(
                          // margin: const EdgeInsets.only(
                          //   bottom: 6,
                          // ),
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
                                  Radio(
                                    activeColor: Theme.of(context)
                                        .progressIndicatorTheme
                                        .color,
                                    value: "${companies![index]['name']}",
                                    groupValue: size,
                                    onChanged: (value) {
                                      setState(() {
                                        size = value.toString();
                                      });
                                    },
                                  ),

                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                  companies![index]['name'] == size
                                      ? Row(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  decrement();
                                                },
                                                child: const Icon(
                                                  CupertinoIcons.minus_circle,
                                                  color: Colors.grey,
                                                )),
                                            Container(
                                              width: 30,
                                              child: Center(
                                                  child: Text("$_counter",
                                                      style: textStyle(
                                                          16,
                                                          Colors.black87,
                                                          FontWeight.w700))),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  increment();
                                                },
                                                child: const Icon(
                                                    CupertinoIcons.plus_circle,
                                                    color: Colors.grey)),
                                          ],
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
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
                }),
          ],
        )),
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
              size == "Custom"
                  ? _buildTextField(
                      labelText: 'Pacel Details',
                      hintText: "Tikuda kutama ",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Details are required';
                        }
                        return null;
                      },
                      controller: _parcel,
                    )
                  : SizedBox.fromSize()
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
      onCompleted: () async {
        _navigator();
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
                Text('Welcome to GoFasta Courier Center'.toUpperCase(),
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
        cursorRadius: const Radius.circular(15),
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

  _navigator() async {
    Logix().getPickup(_pickUpAddress.text);
    Logix().getDestination(_destination.text);
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    Logix().getDistance(business.read("lat1"), business.read("lon1"),
        business.read("lat2"), business.read("lon2"));
    payment();
  }

  payment() {
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) => Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/images/extended.png"),
                      fit: BoxFit.cover,
                      opacity: 0.45),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(19),
                      topRight: Radius.circular(19)),
                  color: Colors.lightBlue.shade600),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Parcel Summary',
                            style:
                                textStyle(16, Colors.white70, FontWeight.bold),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                business.erase();
                              },
                              child: const Icon(AntDesign.closecircleo, color: Colors.white,))
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/extended.png"),
                              fit: BoxFit.cover,
                              opacity: 0.54),
                          borderRadius: BorderRadius.all(
                            Radius.circular(19),
                          ),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, left: 8, top: 8),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.23,
                                decoration: const BoxDecoration(
                                  color: Colors.white38,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 12, 12, 0),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,

                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.26,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            DetailsWidget(
                                              heading:
                                                  CupertinoIcons.location_solid,
                                              head: "Pick-up",
                                              title: _pickUpAddress.text,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            DetailsWidget(
                                              heading: Icons.whatsapp_outlined,
                                              head: "Pick-up Number",
                                              title: _phoneNumber.text,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            DetailsWidget(
                                              heading:
                                                  CupertinoIcons.location_solid,
                                              head: "Destination",
                                              title: _destination.text,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            DetailsWidget(
                                              heading: Icons.whatsapp_outlined,
                                              head: "Destination Number",
                                              title: _destinationNumber.text,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.009,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.26,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            DetailsWidget(
                                              heading:
                                                  MaterialCommunityIcons.scale,
                                              head: "Weight ",
                                              title:
                                                  "${_counter.toString()} kgs",
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            DetailsWidget(
                                              heading: Entypo.shopping_bag,
                                              head: "Product Type ",
                                              title: _chosenType!,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            DetailsWidget(
                                              heading: AntDesign.clockcircleo,
                                              head: "Delivery Period ",
                                              title: _chosenValue!,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            DetailsWidget(
                                              heading: MaterialCommunityIcons
                                                  .office_building,
                                              head: "Delivery Company ",
                                              title: company,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Divider(),
                            RadioListTile<Payment>(
                              visualDensity: VisualDensity.compact,
                              dense: true,
                              activeColor: Theme.of(context).dividerColor,
                              title: Text(
                                'Innbucks',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              value: Payment.innbucks,
                              groupValue: _payment,
                              onChanged: (Payment? value) {
                                setState(() {
                                  _payment = value;
                                });
                              },
                            ),
                            const Divider(),
                            RadioListTile<Payment>(
                              visualDensity: VisualDensity.compact,
                              dense: true,
                              activeColor: Theme.of(context).dividerColor,
                              title: Row(
                                children: [
                                  Text(
                                    'Ecocash',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ],
                              ),
                              value: Payment.ecocash,
                              groupValue: _payment,
                              onChanged: (Payment? value) {
                                setState(() {
                                  _payment = value;
                                });
                              },
                            ),
                            const Divider(),
                            RadioListTile<Payment>(
                              visualDensity: VisualDensity.compact,
                              dense: true,
                              activeColor: Theme.of(context).dividerColor,
                              title: Row(
                                children: [
                                  Text(
                                    'Wallet',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ],
                              ),
                              value: Payment.balance,
                              groupValue: _payment,
                              onChanged: (Payment? value) {
                                setState(() {
                                  _payment = value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 14.0, bottom: 20, right: 14),
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(19)),
                                    color: Colors.black12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "${business.read('distance')} KM",
                                          style: textStyle(20, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "\$3.50",
                                          style: textStyle(20, Colors.black,
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    MaterialButton(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () {},
                                      child: Container(
                                          padding:
                                              const EdgeInsets.fromLTRB(6, 6, 6, 6),
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(19)),
                                            color: Colors.lightBlue.shade600,
                                          ),
                                          child: Text(
                                            "Checkout".toUpperCase(),
                                            style: textStyle(16, Colors.white,
                                                FontWeight.bold),
                                          )),
                                    )
                                  ],
                                ),
                              ),
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
        });
  }

  void _uploadShipment() async {
    final shipmentId = const Uuid().v4();
    User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    final isValid = _formKey.currentState!.validate() &&
        _sndformKey.currentState!.validate();

    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseFirestore.instance
            .collection('courier')
            .doc(shipmentId)
            .set({
          'shipmentId': shipmentId,
          'sendBy': uid,
          'pickupAd': _pickUpAddress.text,
          'pickupNumber': _phoneNumber.text,
          'destination': _destination.text,
          'category': size,
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
          size = 'Small';
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

  void doNothing(BuildContext context) {}

  @override
  void dispose() {
    _pickUpAddress.dispose();
    _phoneNumber.dispose();
    _destinationNumber.dispose();

    super.dispose();
  }
}

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
    required this.heading,
    required this.head,
    required this.title,
  }) : super(key: key);

  final IconData heading;
  final String head;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              heading,
              size: 12,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              head,
              style: textStyle(10, Colors.black54, FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(
          height: 3,
        ),
        Row(
          children: [
            const SizedBox(
              width: 18,
            ),
            Text(title,
                textAlign: TextAlign.justify,
                style: textStyle(10, Colors.black87, FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
