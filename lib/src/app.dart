import 'package:flutter/material.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/account_games/pembeli/pembeli_daftar_akun.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: MyColors.dark,
          selectionColor: MyColors.dark.withOpacity(0.5),
          selectionHandleColor: MyColors.dark,
        ),
      ),
      home: const PembeliDaftarAkunGame(),
    );
  }
}
