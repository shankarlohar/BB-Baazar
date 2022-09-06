import 'package:bb_baazar/views/auth/landing_customer_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BB Baazar',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Brand-Bold",
        ),
        home: LandingCustomerScreen());
  }
}
