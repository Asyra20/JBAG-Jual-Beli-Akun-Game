import 'package:flutter/material.dart';
import 'package:jbag/src/features/account_games/daftar_akun_pembeli/profil_penjual_screen.dart';
import 'package:jbag/src/features/account_games/model/akun_game_model.dart';
import 'package:jbag/src/features/cart/keranjang_screen.dart';
import 'package:jbag/src/features/cart/model/keranjang_item.dart';
import 'package:jbag/src/features/checkout/checkout_screen.dart';

class DetailAkunScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  const DetailAkunScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final AkunGameModel akunGame = AkunGameModel(
      id: 1,
      gameId: 1,
      judul: "AKUN SKIN BLESSED CHARLOTTE HEXSWORD",
      deskripsi: "disertai winrate 80%",
      harga: 100000,
      gambar: "images/",
      penjualId: 1,
      usernamePenjual: "NopStore",
    );

    final List<KeranjangItem> checkoutData = [
      KeranjangItem(
          id: akunGame.id,
          idAkunGame: akunGame.id,
          judul: akunGame.judul,
          harga: akunGame.harga,
          idPenjual: akunGame.penjualId,
          usernamePenjual: akunGame.usernamePenjual),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFFFFAFF)),
        title: const Text(
          'Detail Akun',
          style: TextStyle(
            fontFamily: 'LeagueGothic',
            color: Color(0xFFFFFAFF),
            fontSize: 35,
          ),
        ),
        backgroundColor: Color(0xFF131A2A),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF131A2A),
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
                      Image.network(imageUrl,
                          width: double.infinity, fit: BoxFit.cover),
                      SizedBox(height: 16),
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFAFF),
                        ),
                      ),
                      SizedBox(height: 16),
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
                          'NopStore',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFFAFF),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        price,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFAFF),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        height: 430,
                        color: Colors.white,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deskripsi Akun',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF131A2A),
                              ),
                            ),
                            SizedBox(height: 8),
                            Expanded(
                              child: Text(
                                '',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: Color(0xFF131A2A),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Color(0xFF131A2A),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KeranjangScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color(0xFFFFC639),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Color(0xFF131A2A),
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
                            groupedIdPenjual: akunGame.penjualId.toString(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color(0xFFFFC639),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
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
