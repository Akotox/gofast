import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_pages.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    const HomePage(),
    const HomePage(),
    const HomePage(),
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
