import 'package:dailyhabit_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginScreen(), debugShowCheckedModeBanner: false);
  }
}
