import 'package:flutter/material.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/screens/splashscreen.dart';
import 'package:gofast/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Fast',
      debugShowCheckedModeBanner: false,
      theme: ParcelAppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
