import 'package:flutter/material.dart';
import 'package:jbag/src/features/account_games/daftar_akun_penjual.dart';
import 'package:jbag/src/features/auth/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
