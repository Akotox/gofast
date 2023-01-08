import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/global/global_variables.dart';
import 'package:gofast/models/user_model.dart';
import 'package:gofast/screens/courier.dart';
import 'package:gofast/screens/profile.dart';
import 'package:gofast/services/firebase_services.dart';

class MainCourier extends StatefulWidget {
  const MainCourier({
    Key? key,
  }) : super(key: key);

  @override
  State<MainCourier> createState() => _MainCourierState();
}

class _MainCourierState extends State<MainCourier> {
  int pageIndex = 1;
  FirebaseServices _services = FirebaseServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    
  }


  List<Widget> pageList = <Widget>[
    const HomePage(),
    const CourierPage(),
    const Notifixations(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pageList[pageIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          child: BottomNavigationBar(
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedLabelStyle: Theme.of(context).textTheme.headline5,
              unselectedLabelStyle: Theme.of(context).textTheme.headline5,
              items: [
                BottomNavigationBarItem(
                  icon: pageIndex == 0
                      ? const Icon(MaterialCommunityIcons.bike_fast)
                      : const Icon(MaterialCommunityIcons.bike_fast),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: pageIndex == 1
                      ? const Icon(MaterialCommunityIcons.truck_fast_outline)
                      : const Icon(MaterialCommunityIcons.truck_fast_outline),
                  label: 'Deliveries',
                ),
                BottomNavigationBarItem(
                  icon: pageIndex == 2
                      ? const Icon(Ionicons.notifications_circle)
                      : const Icon(Ionicons.notifications_circle),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: pageIndex == 3
                      ? const Icon(FontAwesome.user_circle_o)
                      : const Icon(
                          FontAwesome.user_circle_o,
                        ),
                  label: 'Profile',
                ),
              ],
              currentIndex: pageIndex,
              unselectedItemColor: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
              selectedItemColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              onTap: ((value) {
                setState(() {
                  setState(() {
                    pageIndex = value;
                  });
                });
              })),
        ));
  }
}
