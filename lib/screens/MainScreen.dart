import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/models/user_model.dart';
import 'package:gofast/screens/profile.dart';
import 'package:gofast/services/firebase_services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseServices _services = FirebaseServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    getDataOnce();
    super.initState();
  }

  void getDataOnce() async {
    final ref = _services.users.doc(_auth.currentUser?.uid).withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userdata, _) => userdata.toFirestore(),
        );
    final docSnap = await ref.get();
    final thisUser = docSnap.data(); // Convert to City object
    if (thisUser != null && mounted) {
      setState(() {
        munhu = thisUser;
      });
    }
  }

  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    const HomePage(),
    const Notifixations(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
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
                      selectedLabelStyle: Theme.of(context).textTheme.headline5,
                      unselectedLabelStyle:
                          Theme.of(context).textTheme.headline5,
                      items: [
                        BottomNavigationBarItem(
                          icon: pageIndex == 0
                              ? const Icon(MaterialCommunityIcons.bike_fast)
                              : const Icon(MaterialCommunityIcons.bike_fast),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: pageIndex == 1
                              ? const Icon(Ionicons.notifications_circle)
                              : const Icon(Ionicons.notifications_circle),
                          label: 'Notifications',
                        ),
                        BottomNavigationBarItem(
                          icon: pageIndex == 2
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
