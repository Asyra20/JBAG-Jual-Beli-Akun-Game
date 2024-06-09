import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/features/auth/registrasi_pembeli.dart';
import 'package:jbag/src/features/auth/registrasi_penjual.dart';

class RegistrasiScreen extends StatelessWidget {
  const RegistrasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF131A2A),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Color(0xFFFFFAFF),
          ),
        ),
        backgroundColor: const Color(0xFF131A2A),
        elevation: 0,
      ),
      body: const RegistrasiBody(),
    );
  }
}

class RegistrasiBody extends StatelessWidget {
  const RegistrasiBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'REGISTRASI',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'BebasNeue',
                fontSize: 48,
                color: Color(0xFFFFFAFF),
              ),
            ),
            const SizedBox(height: 50),
            MyButtonForm(
              label: "PENJUAL",
              color: const Color(0xFFFFC639),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrasiPenjual()),
                );
              },
            ),
            const SizedBox(height: 20),
            MyButtonForm(
              label: "PEMBELI",
              color: const Color(0xFFFFC639),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrasiPembeli()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyButtonForm extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const MyButtonForm({
    super.key,
    required this.label,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: const Color(0xFF131A2A),
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
        textStyle: const TextStyle(
          fontSize: 32,
          fontFamily: 'BebasNeue',
        ),
      ),
      child: Text(label),
    );
  }
}
