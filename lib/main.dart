import 'package:flutter/material.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/providers/shipment.dart';
import 'package:gofast/providers/shipment_state.dart';
import 'package:gofast/screens/delivery_widget.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
          
          ListenableProvider (create: (_) => ShipmentProvider()),
          ChangeNotifierProvider(create: (_) =>MyData()),
        ],
    child: const MyApp()));
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
