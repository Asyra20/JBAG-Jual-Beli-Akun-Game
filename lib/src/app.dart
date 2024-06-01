import 'package:flutter/material.dart';
import 'package:jbag/src/features/cart/keranjang_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KeranjangScreen(),
    );
  }
}
