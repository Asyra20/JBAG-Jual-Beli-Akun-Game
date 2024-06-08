import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/features/cart/model/keranjang_item.dart';
import 'package:jbag/src/features/checkout/model/payment_method_penjual.dart';
import 'package:jbag/src/features/transaction/detail_transaksi.dart';
import 'package:jbag/src/utils/format/currency_format.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key, required this.itemKeranjang});

  final List<KeranjangItem> itemKeranjang;

  final List<PaymentMethodPenjual> checkoutData = [
    PaymentMethodPenjual(
        usernamePenjual: "NOP Gaming Store",
        nama: "Dana",
        image: "assets/logo/logo-dana.png"),
    PaymentMethodPenjual(
        usernamePenjual: "Dzzzzzz Store",
        nama: "OVO",
        image: "assets/logo/logo-ovo.png"),
  ];

  @override
  Widget build(BuildContext context) {
    int totalHarga = itemKeranjang
        .map((item) => item.harga!)
        .reduce((total, current) => total + current);

    Map<String, Map<String, dynamic>> grupPenjual = {};

    for (var penjual in checkoutData) {
      grupPenjual[penjual.usernamePenjual!] = {
        'paymentMethod': penjual,
        'items': itemKeranjang
            .where((item) => item.usernamePenjual == penjual.usernamePenjual)
            .toList(),
      };
    }

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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: grupPenjual.keys.length,
              itemBuilder: (context, index) {
                final penjual = grupPenjual.keys.elementAt(index); // keys
                final itemPenjual = grupPenjual[penjual]!;

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        penjual,
                        style: const TextStyle(
                          fontFamily: 'BebasNeue',
                          fontSize: 28,
                          color: Color(0xFFFFFAFF),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: itemPenjual["items"].length,
                        itemBuilder: (context, index) {
                          final item = itemPenjual["items"][index];

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            color: const Color(0xFFECE8E1),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        maxLines: 1,
                                        item.judul,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontFamily: 'LeagueGothic',
                                          fontSize: 24,
                                          color: Color(0xFF393E46),
                                        ),
                                      ),
                                      Text(
                                        maxLines: 1,
                                        CurrencyFormat.convert2Idr(
                                            item.harga, 2),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontFamily: 'BebasNeue',
                                          fontSize: 32,
                                          color: Color(0xFF131A2A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: const Color(0xFFFFFAFF),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Metode Pembayaran",
                                    style: TextStyle(
                                      fontFamily: 'LeagueGothic',
                                      fontSize: 28,
                                      color: Color(0xFF393E46),
                                    ),
                                  ),
                                  Image.asset(
                                    itemPenjual["paymentMethod"].image,
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFFFC639), width: 2),
              ),
              child: Column(
                children: [
                  HargaRow(
                    text: "Harga Total",
                    harga: totalHarga.toInt(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
              text: "Buat Transaksi",
              color: const Color(0xFFFFC639),
              padding: 40,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailTransaksi(),
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
