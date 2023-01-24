import 'package:flutter/material.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/services/app_userstate.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigator();
  }

  _navigator() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const AppUserState()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  }
}
