import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/transaction/model/detail_transaksi_model.dart';
import 'package:jbag/src/utils/format/currency_format.dart';
import 'package:jbag/src/utils/json_printer.dart';

class PenjualKirimAkun extends StatefulWidget {
  final int _transaksiId;

  const PenjualKirimAkun({
    super.key,
    required int transaksiId,
  }) : _transaksiId = transaksiId;

  @override
  State<PenjualKirimAkun> createState() => _PenjualKirimAkunState();
}

class _PenjualKirimAkunState extends State<PenjualKirimAkun> {
  late Future<void> futureDetail;

  DetailTransaksiModel? detailTransaksi;

  final TextEditingController _uidAkun = TextEditingController();
  final TextEditingController _emailAkun = TextEditingController();
  final TextEditingController _passwordAkun = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark,
      appBar: AppBar(
        backgroundColor: MyColors.dark,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
                        'Transaksi Detail KOSONG!',
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
                            "Tanggal Waktu",
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
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.accent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 32,
                            fontFamily: 'BebasNeue',
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lihat Bukti Pembayaran',
                              style: TextStyle(
                                fontFamily: 'LeagueGothic',
                                fontSize: 18,
                                color: MyColors.secondary,
                              ),
                            ),
                            FaIcon(
                              FontAwesomeIcons.magnifyingGlassPlus,
                              color: MyColors.secondary,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        color: MyColors.accent,
                        child: Text(
                          detailTransaksi!.emailPembeli!,
                          style: const TextStyle(
                            fontFamily: 'LeagueGothic',
                            fontSize: 18,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: detailTransaksi!.akun!.length,
                        itemBuilder: (context, index) {
                          final item = detailTransaksi!.akun![index];

                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(height: 5),
                              const Divider(),
                              const SizedBox(height: 5),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: DropdownAccountItem(
                                title: item.judul!,
                                price: item.harga!,
                                uidController: _uidAkun,
                                emailController: _emailAkun,
                                passwordController: _passwordAkun,
                                deksripsiController: _deskripsiController,
                              ),
                              ),
                            ],
                          );
                        },
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
                          "*Pastikan tidak salah input saat melakukan pengiriman",
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
          children: [],
        ),
      ),
    );
  }
}

class DropdownAccountItem extends StatefulWidget {
  final String title;
  final int price;
  final TextEditingController uidController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController deksripsiController;

  const DropdownAccountItem({
    super.key,
    required this.title,
    required this.price,
    required this.uidController,
    required this.emailController,
    required this.passwordController,
    required this.deksripsiController,
  });

  @override
  State<DropdownAccountItem> createState() => _DropdownAccountItemState();
}

class _DropdownAccountItemState extends State<DropdownAccountItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.title),
      subtitle: Text(CurrencyFormat.convert2Idr(widget.price.toInt(), 2)),
      backgroundColor: MyColors.primary,
      textColor: MyColors.secondary,
      children: [
        MyTextField(
            label: "UID",
            isReadOnly: false,
            controller: widget.uidController,
            inputType: TextInputType.text),
        MyTextField(
            label: "Email",
            isReadOnly: false,
            controller: widget.emailController,
            inputType: TextInputType.emailAddress),
        MyTextField(
          label: "Password",
          isReadOnly: false,
          controller: widget.passwordController,
          inputType: TextInputType.text,
        ),
        MyTextField(
          label: "Deskripsi",
          isReadOnly: false,
          controller: widget.deksripsiController,
          inputType: TextInputType.multiline,
          maxLines: 3,
        ),
      ],
      onExpansionChanged: (bool expanding) =>
          setState(() => isExpanded = expanding),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String label;
  final bool isReadOnly;
  final TextEditingController controller;
  final TextInputType inputType;
  final IconButton? suffixIcon;
  final int? maxLines;

  const MyTextField({
    super.key,
    required this.label,
    required this.isReadOnly,
    required this.controller,
    required this.inputType,
    this.suffixIcon,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: inputType,
        readOnly: isReadOnly,
        controller: controller,
        obscureText: (label == "Password" ? true : false),
        cursorColor: MyColors.dark,
        maxLines: maxLines ?? 1,
        style: const TextStyle(
          fontSize: 32,
          fontFamily: 'LeagueGothic',
          color: Color(0xFF131A2A),
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          filled: true,
          fillColor: const Color(0xFFECE8E1),
          hintText: label,
          hintStyle: const TextStyle(
            color: Color(0xFF393E46),
            fontFamily: 'LeagueGothic',
            fontSize: 32,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
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
