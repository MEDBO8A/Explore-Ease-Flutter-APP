import 'package:explore_ease/firebase_options.dart';
import 'package:explore_ease/pages/state.dart';
import 'package:explore_ease/services/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (ConnectivityService().checkConnectivity()==false) {
      return ConnectivityService().noConnectionAlert();
    } else {
      return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStatepage(),
    );
    }
  }
}
