import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/providers/shipment.dart';
import 'package:gofast/screens/courier.dart';
import 'package:gofast/screens/profile.dart';
import 'package:gofast/services/firebase_services.dart';
import 'package:provider/provider.dart';

class MainCourier extends StatefulWidget {
  const MainCourier({
    Key? key,
  }) : super(key: key);

  @override
  State<MainCourier> createState() => _MainCourierState();
}

class _MainCourierState extends State<MainCourier> {
  int pageIndex = 0;
  int userIndex = 0;

  List<Widget> userList = <Widget>[
    const HomePage(),
    const Notifixations(),
    const Profile(),
  ];

  List<Widget> pageList = <Widget>[
    const HomePage(),
    const CourierPage(),
    const Notifixations(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<ShipmentProvider>(context).thisUser;

    return Scaffold(
      body: user?['courierVerification'] != true
          ? Stack(
              children: [
                userList[userIndex],
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Theme(
                          data: Theme.of(context).copyWith(
                            // sets the background color of the `BottomNavigationBar`
                            canvasColor: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                          ),
                          child: BottomNavigationBar(
                              selectedFontSize: 12,
                              backgroundColor: Theme.of(context).dividerColor,
                              unselectedFontSize: 12,
                              selectedLabelStyle:
                                  Theme.of(context).textTheme.headline5,
                              unselectedLabelStyle:
                                  Theme.of(context).textTheme.headline5,
                              items: [
                                BottomNavigationBarItem(
                                  icon: userIndex == 0
                                      ? const Icon(
                                          MaterialCommunityIcons.bike_fast)
                                      : const Icon(
                                          MaterialCommunityIcons.bike_fast),
                                  label: 'Home',
                                ),
                                BottomNavigationBarItem(
                                  icon: userIndex == 1
                                      ? const Icon(
                                          Ionicons.notifications_circle)
                                      : const Icon(
                                          Ionicons.notifications_circle),
                                  label: 'Notifications',
                                ),
                                BottomNavigationBarItem(
                                  icon: userIndex == 2
                                      ? const Icon(FontAwesome.user_circle_o)
                                      : const Icon(
                                          FontAwesome.user_circle_o,
                                        ),
                                  label: 'Profile',
                                ),
                              ],
                              currentIndex: userIndex,
                              unselectedItemColor: Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .unselectedItemColor,
                              selectedItemColor: Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .selectedItemColor,
                              onTap: ((value) {
                                setState(() {
                                  setState(() {
                                    userIndex = value;
                                  });
                                });
                              }))),
                    ),
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                pageList[pageIndex],
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          // sets the background color of the `BottomNavigationBar`
                          canvasColor: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor,
                        ),
                        child: BottomNavigationBar(
                            selectedFontSize: 12,
                            backgroundColor: Theme.of(context).dividerColor,
                            unselectedFontSize: 12,
                            selectedLabelStyle:
                                Theme.of(context).textTheme.headline5,
                            unselectedLabelStyle:
                                Theme.of(context).textTheme.headline5,
                            items: [
                              BottomNavigationBarItem(
                                icon: pageIndex == 0
                                    ? const Icon(
                                        MaterialCommunityIcons.bike_fast)
                                    : const Icon(
                                        MaterialCommunityIcons.bike_fast),
                                label: 'Home',
                              ),
                              BottomNavigationBarItem(
                                icon: pageIndex == 1
                                    ? const Icon(MaterialCommunityIcons
                                        .truck_fast_outline)
                                    : const Icon(MaterialCommunityIcons
                                        .truck_fast_outline),
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
                            selectedItemColor: Theme.of(context)
                                .bottomNavigationBarTheme
                                .selectedItemColor,
                            onTap: ((value) {
                              setState(() {
                                setState(() {
                                  pageIndex = value;
                                });
                              });
                            })),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
