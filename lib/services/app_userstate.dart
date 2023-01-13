import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/screens/courier.dart';
import 'package:gofast/screens/mainscreen_courier.dart';


class AppUserState extends StatelessWidget {
  static const String id = 'app-user-state';

  const AppUserState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.data == null) {
            return const Login();
          } else if (userSnapshot.hasData) {
            
            return  const MainCourier();
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
          return const Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          );
        });
  }
}
