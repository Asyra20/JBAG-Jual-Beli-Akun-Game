import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/features/transaction/transaksi_screen.dart';
import 'package:jbag/src/utils/format/currency_format.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final Map<String, dynamic> checkoutData = {
    'judul': 'AKUN SULTAN GG, HERO MAX DAN RECALL TAS TAS PERMANENT',
    'penjual': 'NOP Gaming Store',
    'payment': {
      'paymentMethod': {
        'nama': "Dana",
        'image': "assets/logo/logo-dana.png",
      },
      'namaProfilEwallet': "NOP NOP Gaming Store",
      'nomorEwallet': "0852250411",
    },
    'harga': 5000000,
  };

  @override
  Widget build(BuildContext context) {
    double biayaAdmin = checkoutData['harga'] * 0.002;
    double hargaTotal = checkoutData['harga'] + (checkoutData['harga'] * 0.002);

    return Scaffold(
      backgroundColor: const Color(0xFF131A2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131A2A),
        leading: IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: Color(0xFFFFFAFF),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Checkout',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: 48,
                  color: Color(0xFFFFFAFF),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    checkoutData['judul'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'LeagueGothic',
                      fontSize: 38,
                      color: Color(0xFFFFFAFF),
                    ),
                  ),
                  Text(
                    checkoutData['penjual'],
                    style: const TextStyle(
                      fontFamily: 'LeagueGothic',
                      fontSize: 24,
                      color: Color(0xFFECE8E1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: const Color(0xFFFFFAFF),
                      child: Image.asset(
                        checkoutData['payment']['paymentMethod']['image'],
                        height: 40,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFFFC639), width: 2),
                ),
                child: Column(
                  children: [
                    HargaRow(
                      text: "Harga",
                      harga: checkoutData['harga'],
                    ),
                    HargaRow(
                      text: "Biaya Admin",
                      harga: biayaAdmin.toInt(),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1.0,
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                          ),
                        ),
                      ],
                    ),
                    HargaRow(
                      text: "Harga Total",
                      harga: hargaTotal.toInt(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: MyButton(
                text: "Batal",
                color: const Color(0xFFF9564F),
                // onPressed: () => Navigator.pop(context),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: MyButton(
                text: "Selanjutnya",
                color: const Color(0xFFFFC639),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      checkoutData["hargaTotal"] = hargaTotal.toInt();
                      return TransaksiScreen(transaksiData: checkoutData);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.padding = 20,
  });

  final String text;
  final Color color;
  final VoidCallback onPressed;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: const Color(0xFF131A2A),
        padding: EdgeInsets.symmetric(horizontal: padding),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        textStyle: const TextStyle(
          fontSize: 32,
          fontFamily: 'BebasNeue',
          color: Color(0xFF393E46),
        ),
      ),
      child: Text(text),
    );
  }
}

class HargaRow extends StatelessWidget {
  const HargaRow({
    super.key,
    required this.harga,
    required this.text,
  });

  final String text;
  final int harga;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'LeagueGothic',
            fontSize: 28,
            color: Color(0xFFECE8E1),
          ),
        ),
        Text(
          CurrencyFormat.convert2Idr(harga, 2),
          style: const TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: 32,
            color: Color(0xFFECE8E1),
          ),
        ),
      ],
    );
  }
}
