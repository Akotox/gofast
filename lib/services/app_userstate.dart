import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/screens/courier.dart';
import 'package:gofast/screens/mainscreen_courier.dart';
import 'package:gofast/widgets/custom_snack.dart';
import 'package:lottie/lottie.dart';

class AppUserState extends StatefulWidget {
  static const String id = 'app-user-state';

  const AppUserState({
    Key? key,
  }) : super(key: key);

  @override
  State<AppUserState> createState() => _AppUserStateState();
}

class _AppUserStateState extends State<AppUserState> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.data == null) {
            return const Login();
          } else if (userSnapshot.hasData) {
            route();
            // return  const MainScreen();
          } else if (userSnapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('An error has occurred'),
              ),
            );
          } else if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return  Scaffold(
            body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).iconTheme.color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 200,
                height: 200,
                child: Lottie.asset(
                  "assets/json/delivery.json",
                  // color: Colors.white,
                )),
            const SizedBox(
              height: 8,
            ),
            Text("GoFasta", style: textStyle(52, Colors.white, FontWeight.bold)),
             Text("Reliability in every delivery", style: textStyle(16, Colors.white38, FontWeight.w500))
          ],
        ),
      ),
    
          );
        });
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('courierVerification') != true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainCourier(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainCourier(),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            duration:  Duration(seconds: 3),
            content: CustomSnackbarContent(
              message: "Oh snap!",
              errorText: ("There is no account with those credentials"),
              containerClr:  Color.fromRGBO(3, 62, 101, 1),
              bubblesClr:  Color(0xFF062026),
            ),
          ),
        );
      }
    });
  }
}
