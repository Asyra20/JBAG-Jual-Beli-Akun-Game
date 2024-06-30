import 'package:flutter/material.dart';
import 'package:jbag/src/features/account_games/penjual/penjual_kirim_akun.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PenjualKirimAkun(
                          transaksiId: 1,
                        ),
    );
  }
}
