import 'package:flutter/material.dart';
import 'package:jbag/src/features/admin/admin_homescreen.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeS(
        
      ),
    );
  }
}