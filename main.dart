import 'package:flutter/material.dart';
import 'screen/welcome_screen.dart';
import 'objectbox_store.dart'; // Import the store initialization

void main() async {
  // Initialize ObjectBox before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await initObjectBox();
  runApp(CarMaintenanceApp());
}

class CarMaintenanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Maintenance',
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
