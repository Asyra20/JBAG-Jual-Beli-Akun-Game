import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/utils/format/currency_format.dart';
import 'package:jbag/src/features/checkout/checkout_screen.dart';
import 'package:jbag/src/features/cart/model/keranjang_item.dart';
import 'package:jbag/src/features/account_games/model/akun_game_model.dart';
import 'package:jbag/src/features/account_games/pembeli/profil_penjual.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PembeliDetailAkun extends StatefulWidget {
  final AkunGameModel akunGameDetail;

  const PembeliDetailAkun({
    super.key,
    required this.akunGameDetail,
  });

  @override
  State<PembeliDetailAkun> createState() => _PembeliDetailAkunState();
}

class _PembeliDetailAkunState extends State<PembeliDetailAkun> {
  int userId = 0;

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    if (user != null) {
      setState(() {
        userId = user['id'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<KeranjangItem> checkoutData = [
      KeranjangItem(
        id: widget.akunGameDetail.id,
        idAkunGame: widget.akunGameDetail.id,
        judul: widget.akunGameDetail.judul,
        harga: widget.akunGameDetail.harga,
        idPenjual: widget.akunGameDetail.penjualId,
        usernamePenjual: widget.akunGameDetail.usernamePenjual,
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
                        '$baseUrl/${widget.akunGameDetail.gambar!}',
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset('assets/logo/logo-splash.png');
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.akunGameDetail.judul!,
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
                              builder: (context) => ProfilPenjual(),
                            ),
                          );
                        },
                        child: Text(
                          widget.akunGameDetail.usernamePenjual!,
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
                        CurrencyFormat.convert2Idr(
                            widget.akunGameDetail.harga!, 2),
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
                                widget.akunGameDetail.deskripsi == null
                                    ? "-"
                                    : widget.akunGameDetail.deskripsi!,
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
                    onPressed: () async {
                      try {
                        await tambahKeranjang(userId, widget.akunGameDetail.id);
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                          return;
                        }
                      }
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Berhasil menambahkan")));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: MyColors.dark,
                      backgroundColor: MyColors.accent,
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
                                widget.akunGameDetail.penjualId.toString(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: MyColors.dark,
                      backgroundColor: MyColors.accent,
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

  Future<void> tambahKeranjang(int userId, int? id) async {
    final response = await http.post(
      Uri.parse('$apiEndPoint/keranjang'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': userId,
        'akun_game_id': id,
      }),
    );

    final responseBody = json.decode(response.body);

    if ((response.statusCode == 200 || response.statusCode == 201) &&
        responseBody['success'] == true) {
      if (responseBody['success'] == false) {
        throw Exception(responseBody['message']);
      }
    } else {
      throw Exception(responseBody['message']);
    }
  }
}
