import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/transaction/history/history_transaksi_screen.dart';
import 'package:jbag/src/features/transaction/bukti_pembayaran_screen.dart';
import 'package:jbag/src/features/transaction/model/detail_transaksi_model.dart';
import 'package:jbag/src/utils/format/currency_format.dart';
import 'package:jbag/src/utils/json_printer.dart';

class DetailTransaksi extends StatefulWidget {
  final int _transaksiId;

  const DetailTransaksi({
    super.key,
    required int transaksiId,
  }) : _transaksiId = transaksiId;

  @override
  State<DetailTransaksi> createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  late Future<void> futureDetail;

  DetailTransaksiModel? detailTransaksi;

  @override
  void initState() {
    super.initState();
    futureDetail = fetchDetailTransaksi(widget._transaksiId);
  }

  Future<void> fetchDetailTransaksi(int transaksiId) async {
    final response =
        await http.get(Uri.parse('$apiEndPoint/transaksi/$transaksiId'));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true) {
        print("DetailTransaksiModel");
        print(JsonPrinter.prettyPrint(responseBody['data']));

        setState(() {
          detailTransaksi = DetailTransaksiModel.fromJson(responseBody['data']);
        });
      } else {
        throw Exception(
            'Failed to fetch detail transaksi: ${responseBody['message']}');
      }
    } else {
      throw Exception(
          'Failed to fetch detail transaksi: ${response.reasonPhrase}');
    }
  }

  Future<bool> deleteTransaksi(int transaksiId) async {
    final url = Uri.parse('$baseUrl/api/transaksi/$transaksiId');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true) {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark,
      appBar: AppBar(
        backgroundColor: MyColors.dark,
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DaftarAkunScreen(),
            ),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: MyColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
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
                        color: MyColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: futureDetail,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: MyColors.white),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(
                          fontFamily: 'LeagueGothic',
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                    );
                  }

                  if (detailTransaksi == null) {
                    return const Center(
                      child: Text(
                        'Keranjang kosong',
                        style: TextStyle(
                          fontFamily: 'LeagueGothic',
                          fontSize: 18,
                          color: Color(0xFFFFFAFF),
                        ),
                      ),
                    );
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Invoice",
                            style: TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: 32,
                              color: MyColors.white,
                            ),
                          ),
                          Text(
                            detailTransaksi!.invoice!,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: 32,
                              color: MyColors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tangal Waktu",
                            style: TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: 32,
                              color: MyColors.white,
                            ),
                          ),
                          Text(
                            detailTransaksi!.tanggalWaktu!,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: 32,
                              color: MyColors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Status Pembayaran",
                            style: TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: 32,
                              color: MyColors.white,
                            ),
                          ),
                          Text(
                            detailTransaksi!.statusPembayaran!,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: 32,
                              color: MyColors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Text(
                        detailTransaksi!.penjual!,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: 'LeagueGothic',
                          fontSize: 42,
                          color: Color(0xFFECE8E1),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: detailTransaksi!.akun!.length,
                        itemBuilder: (context, index) {
                          final item = detailTransaksi!.akun![index];

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            color: MyColors.primary,
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
                                          color: MyColors.dark,
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
                              color: MyColors.white,
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
                                    "$baseUrl/${detailTransaksi!.paymentMethod!.icon!}",
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
                              color: MyColors.primary,
                              child: Text(
                                detailTransaksi!.namaProfilEwallet!,
                                style: const TextStyle(
                                  color: MyColors.dark,
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
                              color: MyColors.primary,
                              child: Text(
                                detailTransaksi!.nomorEwallet!,
                                style: const TextStyle(
                                  color: MyColors.dark,
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
                              harga: detailTransaksi!.hargaTotal!,
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
                            color: MyColors.white,
                          ),
                        ),
                      ),
                    ],
                  );
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
            detailTransaksi?.statusPembayaran == "belum_bayar"
                ? Expanded(
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
                              backgroundColor: MyColors.primary,
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
                                        color: MyColors.dark,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Apakah Ingin Membatalkan Transaksi?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'BebasNeue',
                                        fontSize: 28,
                                        color: MyColors.dark,
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    MyButton(
                                      text: "Batal",
                                      onPressed: () async {
                                        bool isDeleted = await deleteTransaksi(
                                            widget._transaksiId);

                                        if (dialogContext.mounted) {
                                          if (isDeleted) {
                                            Navigator.push(
                                              dialogContext,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const DaftarAkunScreen(),
                                              ),
                                            );
                                          } else {
                                            Navigator.of(
                                              dialogContext,
                                              rootNavigator: true,
                                            ).pop();
                                          }
                                        }
                                      },
                                      color: const Color(0xFFF9564F),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                : const SizedBox(),
            SizedBox(
                width: detailTransaksi?.statusPembayaran == "belum_bayar"
                    ? 30
                    : 0),
            Expanded(
              child: MyButton(
                text: detailTransaksi?.statusPembayaran == "belum_bayar"
                    ? "Selanjutnya"
                    : "Lihat Bukti Pembayaran",
                color: const Color(0xFFFFC639),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BuktiPembayaranScreen(
                        transaksiId: widget._transaksiId,
                        isPaid:
                            detailTransaksi?.statusPembayaran != "belum_bayar",
                      );
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
  final VoidCallback? onPressed;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: MyColors.dark,
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
