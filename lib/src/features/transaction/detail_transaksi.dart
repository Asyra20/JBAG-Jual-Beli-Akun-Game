import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/transaction/bukti_pembayaran_screen.dart';
import 'package:jbag/src/features/transaction/model/detail_transaksi_model.dart';
import 'package:jbag/src/utils/format/currency_format.dart';

class DetailTransaksi extends StatelessWidget {
  const DetailTransaksi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<DetailTransaksiModel> fetchDetailTransaksi(int transaksiId) async {
      final response =
          await http.get(Uri.parse('$baseUrl/api/transaksi/$transaksiId'));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['success'] == true) {
          return DetailTransaksiModel.fromJson(responseBody['data']);
        } else {
          throw Exception(
              'Failed to fetch detail transaksi: ${responseBody['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch detail transaksi: ${response.reasonPhrase}');
      }
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Detail Transaksi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'BebasNeue',
                        fontSize: 48,
                        color: Color(0xFFFFFAFF),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: fetchDetailTransaksi(10),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator(color: MyColors.white));
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(
                          fontFamily: 'LeagueGothic',
                          fontSize: 18,
                          color: Color(0xFFFFFAFF),
                        ),
                      ),
                    );
                  }

                  var data = snapshot.data!;

                  return Expanded(
                      child: Column(
                    children: [
                      Text(
                        data.penjual!,
                        style: const TextStyle(
                          fontFamily: 'LeagueGothic',
                          fontSize: 42,
                          color: Color(0xFFECE8E1),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.akun!.length,
                        itemBuilder: (context, index) {
                          final item = data.akun![index];

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                                        item.judul!,
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
                      const SizedBox(height: 30),
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
                                  Image.network(
                                    "$baseUrl${data.paymentMethod!.icon!}",
                                    height: 30,
                                  ),
                                ],
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
                                data.namaProfilEwallet!,
                                style: const TextStyle(
                                  color: Color(0xFF131A2A),
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
                                data.nomorEwallet!,
                                style: const TextStyle(
                                  color: Color(0xFF131A2A),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFFFFC639), width: 2),
                        ),
                        child: Column(
                          children: [
                            HargaRow(
                              text: "Harga Total",
                              harga: data.hargaTotal!,
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
                  ));
                },
              )
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
                onPressed: () {
                  BuildContext dialogContext;
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      dialogContext = context;
                      return Dialog(
                        backgroundColor: const Color(0xFFECE8E1),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Pemberitahuan",
                                style: TextStyle(
                                  fontFamily: 'BebasNeue',
                                  fontSize: 38,
                                  color: Color(0xFF131A2A),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Apakah Ingin Membatalkan Transaksi?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'BebasNeue',
                                  fontSize: 28,
                                  color: Color(0xFF131A2A),
                                ),
                              ),
                              const SizedBox(height: 25),
                              MyButton(
                                text: "Batal",
                                onPressed: () {
                                  Navigator.of(
                                    dialogContext,
                                    rootNavigator: true,
                                  ).pop();
                                },
                                color: const Color(0xFFF9564F),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
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
                      return const BuktiPembayaranScreen();
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
