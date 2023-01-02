import 'package:flutter/material.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gofast/exports/export_services.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      theme: GoFastaAppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
