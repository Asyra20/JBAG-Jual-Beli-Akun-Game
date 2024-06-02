import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/features/transaction/bukti_pembayaran_screen.dart';
import 'package:jbag/src/utils/format/currency_format.dart';

class TransaksiScreen extends StatelessWidget {
  const TransaksiScreen({
    super.key,
    required this.transaksiData,
  });

  final Map<String, dynamic> transaksiData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131A2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131A2A),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
                'Transaksi',
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
                    transaksiData['judul'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'LeagueGothic',
                      fontSize: 38,
                      color: Color(0xFFFFFAFF),
                    ),
                  ),
                  Text(
                    transaksiData['penjual'],
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
                        transaksiData['payment']['paymentMethod']['image'],
                        height: 40,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: const Color(0xFFECE8E1),
                      child: Text(
                        transaksiData["payment"]["namaProfilEwallet"],
                        style: const TextStyle(
                          color: Color(0xFF393E46),
                          fontSize: 32,
                          fontFamily: 'LeagueGothic',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: const Color(0xFFECE8E1),
                      child: Text(
                        transaksiData["payment"]["nomorEwallet"],
                        style: const TextStyle(
                          color: Color(0xFF393E46),
                          fontSize: 32,
                          fontFamily: 'LeagueGothic',
                        ),
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
                      text: "Harga Total",
                      harga: transaksiData["hargaTotal"].toInt(),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "*Pastikan tidak salah input saat melakukan pembayaran",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Color(0xFFFFFAFF),
                  ),
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
                onPressed: () => Navigator.pop(context),
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
                      return BuktiPembayaranScreen();
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
