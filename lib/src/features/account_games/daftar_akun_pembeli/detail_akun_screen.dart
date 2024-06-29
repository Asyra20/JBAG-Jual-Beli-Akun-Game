import 'package:flutter/material.dart';
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/account_games/daftar_akun_pembeli/profil_penjual_screen.dart';
import 'package:jbag/src/features/account_games/model/akun_game_model.dart';
import 'package:jbag/src/features/cart/keranjang_screen.dart';
import 'package:jbag/src/features/cart/model/keranjang_item.dart';
import 'package:jbag/src/features/checkout/checkout_screen.dart';
import 'package:jbag/src/utils/format/currency_format.dart';

class DetailAkunScreen extends StatelessWidget {
  final AkunGameModel akunGameDetail;

  const DetailAkunScreen({
    super.key,
    required this.akunGameDetail,
  });

  @override
  Widget build(BuildContext context) {
    final List<KeranjangItem> checkoutData = [
      KeranjangItem(
        id: akunGameDetail.id,
        idAkunGame: akunGameDetail.id,
        judul: akunGameDetail.judul,
        harga: akunGameDetail.harga,
        idPenjual: akunGameDetail.penjualId,
        usernamePenjual: akunGameDetail.usernamePenjual,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: MyColors.white),
        title: const Text(
          'Detail Akun',
          style: TextStyle(
            fontFamily: 'LeagueGothic',
            color: MyColors.white,
            fontSize: 35,
          ),
        ),
        backgroundColor: MyColors.dark,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: MyColors.dark,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        '$baseUrl/${akunGameDetail.gambar!}',
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset(
                              'assets/logo/logo-splash.png'); // Ganti dengan path gambar default-mu
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        akunGameDetail.judul!,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: MyColors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilPenjualScreen(),
                            ),
                          );
                        },
                        child: Text(
                          akunGameDetail.usernamePenjual!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        CurrencyFormat.convert2Idr(akunGameDetail.harga!, 2),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: MyColors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        height: 430,
                        color: Colors.white,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deskripsi Akun',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColors.dark,
                              ),
                            ),
                            SizedBox(height: 8),
                            Expanded(
                              child: Text(
                                akunGameDetail.deskripsi == null
                                    ? "-"
                                    : akunGameDetail.deskripsi!,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: MyColors.dark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: MyColors.dark,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const KeranjangScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFFFC639),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: MyColors.dark,
                      size: 24,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                            itemKeranjang: checkoutData,
                            groupedIdPenjual:
                                akunGameDetail.penjualId.toString(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFFFC639),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'BELI',
                      style: TextStyle(
                        fontFamily: 'BebasNeue',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
