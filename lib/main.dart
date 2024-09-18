import 'package:flutter/material.dart';
import 'features/blood_glucose/presentation/pages/blood_glucose_page.dart';

void main() {
  runApp(const BloodGlucoseApp());
}

class BloodGlucoseApp extends StatelessWidget {
  const BloodGlucoseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Glucose App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BloodGlucosePage(),
    );
  }
}
