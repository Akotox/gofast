import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/global/global_variables.dart';
import 'package:gofast/providers/shipment.dart';
import 'package:gofast/screens/profile/edit_profile.dart';
import 'package:gofast/screens/profile/identity.dart';
import 'package:gofast/screens/profile/incoming.dart';
import 'package:gofast/screens/profile/orders.dart';
import 'package:gofast/screens/profile/password.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final TextEditingController _phoneNumberController =
      TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<ShipmentProvider>(context).thisUser;

    return Scaffold(
      backgroundColor: Theme.of(context).highlightColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.355,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  const Color(0xFF03608F).withOpacity(0.8),
                  const Color(0xFFFFFFFF).withOpacity(.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 50, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 35,
                              width: 35,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade100,
                                backgroundImage:
                                    const AssetImage("assets/images/user.png"),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${user!['name']}",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  Text(
                                    "${user['email']}",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditPersonalDetails()));
                            },
                            child: const Icon(Feather.edit, size: 18))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  TilesWidget(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OutGoing()));
                    },
                    title: "OutGoing orders",
                    leading: MaterialCommunityIcons.truck_fast,
                  ),
                  TilesWidget(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const IncomingDeliveries()));
                    },
                    title: "Incoming order",
                    leading: MaterialCommunityIcons.cube_send,
                  ),
                  const TilesWidget(
                    title: "Earnings",
                    leading: AntDesign.wallet,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.104,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Thorough Courier Verification",
                      style: textStyle(14, Colors.black, FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\u2022 Unleash new streams of income.",
                              style:
                                  textStyle(12, Colors.grey, FontWeight.w500),
                            ),
                            Text(
                              "\u2022 Maximize your earning whilst traveling.",
                              style:
                                  textStyle(12, Colors.grey, FontWeight.w500),
                            ),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () {
                            // Get.to(()=>const Verification(),
                            //     transition: Transition.fade,
                            //     duration: const Duration(seconds: 1));
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFA1F2B36),
                            fixedSize: const Size(80, 15),
                            side: const BorderSide(color: Color(0xFA1F2B36)),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                          child: Text(
                            "Verify".toUpperCase(),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.18,
              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TilesWidget(
                    title: "Parcel Message and notifications",
                    leading: Ionicons.notifications_circle_outline,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ForgotPasswordPage()));
                    },
                    child: TilesWidget(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PassWord()));
                      },
                      title: "Request password",
                      leading: AntDesign.unlock,
                    ),
                  ),
                  TilesWidget(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Identity()));
                    },
                    title: "Identity Code",
                    leading: MaterialCommunityIcons.barcode_scan,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // user['courierVerification'] == true
            //     ? const CourierSettings()
            //     : const SizedBox.shrink(),

            const SizedBox(
              height: 10,
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.18,
              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TilesWidget(
                    title: "Service Center",
                    leading: AntDesign.customerservice,
                  ),
                  const TilesWidget(
                    title: "Praise",
                    leading: AntDesign.like2,
                  ),
                  GestureDetector(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const TilesWidget(
                      title: "Logout",
                      leading: AntDesign.logout,
                    ),
                  ),
                ],
              ),
            ),

            // SizedBox(height: 15,),

            Container(
              height: 222,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg.png"),
                      fit: BoxFit.cover,
                      opacity: 0.9),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white12,
                      Color(0xFF03608F),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class TilesWidget extends StatelessWidget {
  final String title;
  final IconData leading;
  final Function()? onTap;

  const TilesWidget({
    Key? key,
    required this.title,
    required this.leading,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(leading),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
      trailing: const Icon(
        AntDesign.right,
        size: 16,
      ),
      // tileColor: Colors.white,
    );
  }
}

class CourierSettings extends StatelessWidget {
  const CourierSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.119,
      decoration: BoxDecoration(color: Colors.grey.shade100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Entypo.fingerprint),
            title: Text(
              "Verification",
              style: Theme.of(context).textTheme.headline5,
            ),
            trailing: const Icon(
              AntDesign.right,
              size: 16,
            ),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: const Icon(AntDesign.wallet),
            title: Text(
              "Earnings",
              style: Theme.of(context).textTheme.headline5,
            ),
            trailing: const Icon(
              AntDesign.right,
              size: 16,
            ),
            tileColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
