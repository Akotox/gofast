import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/global/global_variables.dart';
import 'package:gofast/models/companies.dart';
import 'package:gofast/services/firebase_services.dart';
import 'package:gofast/widgets/shipment_streams/companies.dart';
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
    super.didChangeDependencies();
    _couriers = FirebaseFirestore.instance.collection('company').snapshots();
   
  }


  String productCategory = 'Others';

  @override
  Widget build(BuildContext context) {
    
    
    final steps = [
      CoolStep(
        title: 'Please the Courier Service Provider',
        subtitle: 'Choose a provider or the system automatically pick for you',
        content:
            SingleChildScrollView(child: CompaniesBuilda(couriers: _couriers)),
        validation: () {
          return null;
        },
      ),
      CoolStep(
        title: 'Please select a Category',
        subtitle: 'Choose a category type of your parcel',
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          activeColor:
                              Theme.of(context).progressIndicatorTheme.color,
                          value: 'Food | Perishable',
                          groupValue: productCategory,
                          onChanged: (value) {
                            setState(() {
                              productCategory = value.toString();
                            });
                          },
                        ),
                        Container(
                          height: 99,
                          width: 66,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/small.png"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              parcelSize.last,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "parcelSizeDimension",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "parcelSizeDescription",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  decrement();
                                },
                                child: const Icon(CupertinoIcons.minus_circle)),
                            Container(
                              width: 40,
                              child: Center(
                                  child: Text("$_counter",
                                      style: textStyle(16, Colors.black87,
                                          FontWeight.w700))),
                            ),
                            InkWell(
                                onTap: () {
                                  increment();
                                },
                                child: const Icon(CupertinoIcons.plus_circle)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
            child: IconButton(
                icon: const Icon(
                  AntDesign.leftcircleo,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
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
