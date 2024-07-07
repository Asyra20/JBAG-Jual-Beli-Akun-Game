import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/transaction/model/detail_transaksi_model.dart';
import 'package:jbag/src/features/transaction/penjual/penjual_transaksi_akun.dart';
import 'package:jbag/src/features/transaction/penjual/verifikasi_pembayaran.dart';
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

  final _formKey = GlobalKey<FormState>();

  DetailTransaksiModel? detailTransaksi;

  List<TextEditingController> listUidAkun = [];
  List<TextEditingController> listemailAkun = [];
  List<TextEditingController> listpasswordAkun = [];

  TextEditingController deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureDetail = fetchDetailTransaksi(widget._transaksiId);
  }

  @override
  void dispose() {
    for (var controller in listUidAkun) {
      controller.dispose();
    }
    for (var controller in listemailAkun) {
      controller.dispose();
    }
    for (var controller in listpasswordAkun) {
      controller.dispose();
    }

    super.dispose();
  }

  Future<void> fetchDetailTransaksi(int transaksiId) async {
    final response =
        await http.get(Uri.parse('$apiEndPoint/transaksi/$transaksiId'));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true) {
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
    return Form(
      key: _formKey,
      child: Scaffold(
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
          title: const Text(
            "Detail Transaksi",
            style: TextStyle(
              fontFamily: 'BebasNeue',
              fontSize: 42,
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

                    for (var _ in detailTransaksi!.akun!) {
                      listUidAkun.add(TextEditingController());
                      listemailAkun.add(TextEditingController());
                      listpasswordAkun.add(TextEditingController());
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
                                fontSize: 22,
                                color: MyColors.white,
                              ),
                            ),
                            Text(
                              detailTransaksi!.invoice!,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontFamily: 'BebasNeue',
                                fontSize: 22,
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
                                fontSize: 22,
                                color: MyColors.white,
                              ),
                            ),
                            Text(
                              detailTransaksi!.tanggalWaktu!,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontFamily: 'BebasNeue',
                                fontSize: 22,
                                color: MyColors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: MyColors.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 7,
                                child: Text(
                                  "Lihat Bukti Pembayaran",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'LeagueGothic',
                                    fontSize: 38,
                                    color: MyColors.secondary,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Material(
                                  child: Ink(
                                    decoration: const BoxDecoration(
                                      color: MyColors.primary,
                                    ),
                                    child: InkWell(
                                      highlightColor: MyColors.primary,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VerifikasiPembayaran(
                                                  id: detailTransaksi!.idTransaksi!,
                                              buktiPembayaran: detailTransaksi!
                                                  .buktiPembayaran!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.all(8),
                                        child: const FaIcon(
                                          size: 32,
                                          FontAwesomeIcons.magnifyingGlass,
                                          color: MyColors.secondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                color: MyColors.accent,
                                child: Text(
                                  detailTransaksi!.emailPembeli!,
                                  style: const TextStyle(
                                    fontFamily: 'LeagueGothic',
                                    fontSize: 38,
                                    color: MyColors.dark,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                                  child: ExpansionTile(
                                    title: Text(
                                      item.judul!,
                                      style: const TextStyle(
                                        fontFamily: 'LeagueGothic',
                                        fontSize: 24,
                                        color: MyColors.secondary,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      CurrencyFormat.convert2Idr(item.harga, 2),
                                      style: const TextStyle(
                                        fontFamily: 'LeagueGothic',
                                        fontSize: 28,
                                        color: MyColors.dark,
                                      ),
                                    ),
                                    iconColor: MyColors.dark,
                                    collapsedBackgroundColor: MyColors.white,
                                    collapsedTextColor: MyColors.secondary,
                                    backgroundColor: MyColors.primary,
                                    textColor: MyColors.secondary,
                                    children: [
                                      MyTextField(
                                          label: "UID Akun",
                                          isReadOnly: false,
                                          controller: listUidAkun[index],
                                          inputType: TextInputType.text),
                                      MyTextField(
                                          label: "Email Akun",
                                          isReadOnly: false,
                                          controller: listemailAkun[index],
                                          inputType:
                                              TextInputType.emailAddress),
                                      MyTextField(
                                        label: "Password Akun",
                                        isReadOnly: false,
                                        controller: listpasswordAkun[index],
                                        inputType: TextInputType.text,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          label: "Deskripsi",
                          isReadOnly: false,
                          controller: deskripsiController,
                          inputType: TextInputType.multiline,
                          maxLines: 3,
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: const Color.fromARGB(255, 178, 139, 39),
              disabledForegroundColor: MyColors.dark,
              backgroundColor: const Color(0xFFFFC639),
              foregroundColor: MyColors.dark,
              elevation: 5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 90),
              textStyle: const TextStyle(
                fontSize: 32,
                fontFamily: 'BebasNeue',
                color: MyColors.secondary,
              ),
            ),
            onPressed: detailTransaksi == null
                ? null
                : () async {
                    BuildContext dialogContext;
                    dialogContext = context;
                    if (_formKey.currentState!.validate()) {
                      try {
                        await kirimDataAkun(
                          dialogContext,
                          detailTransaksi!,
                          listUidAkun,
                          listemailAkun,
                          listpasswordAkun,
                          deskripsiController,
                        );
                      } catch (e) {
                        print(e.toString());
                        if (dialogContext.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                        return;
                      }

                      if (!dialogContext.mounted) {
                        return;
                      }
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
                                    "Data Akun Telah dikirim",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'BebasNeue',
                                      fontSize: 28,
                                      color: MyColors.dark,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  MyButton(
                                    text: "OK",
                                    onPressed: () async {
                                      Navigator.pushReplacement(
                                        dialogContext,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PenjualTransaksiAkun(),
                                        ),
                                      );
                                    },
                                    color: MyColors.tertiary,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
            child: const Text("KIRIM"),
          ),
        ),
      ),
    );
  }

  Future<void> kirimDataAkun(
    BuildContext dialogContext,
    DetailTransaksiModel detailTransaksi,
    List<TextEditingController> listUidAkun,
    List<TextEditingController> listemailAkun,
    List<TextEditingController> listpasswordAkun,
    TextEditingController deskripsiController,
  ) async {
    var jsonData = <String, dynamic>{
      "email_pembeli": detailTransaksi.emailPembeli,
      "subjek": "JBAG - ${detailTransaksi.penjual}",
      "nama_penjual": detailTransaksi.penjual,
      "akun": [],
      "deskripsi": deskripsiController.text,
    };

    detailTransaksi.akun!.asMap().forEach((key, value) {
      jsonData["akun"].add({
        "id": value.idDetailTransaksi,
        "akun_game_id": value.idAkunGame,
        "judul": value.judul,
        "harga": value.harga,
        "uid_akun": listUidAkun[key].text,
        "email_akun": listemailAkun[key].text,
        "password_akun": listpasswordAkun[key].text,
      });
    });

    print(JsonPrinter.prettyPrint(jsonData));

    final response = await http.patch(
      Uri.parse('$apiEndPoint/kirim-akun'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(jsonData),
    );

    final responseBody = json.decode(response.body);

    if ((response.statusCode == 200 || response.statusCode == 204) &&
        responseBody['success'] == true) {
      print(responseBody['message']);
      print(responseBody['data']);
      if (responseBody['success'] == false) {
        print(responseBody['data']);
        throw Exception(responseBody['message']);
      }
    } else {
      print(responseBody['data']);
      throw Exception(responseBody['message']);
    }
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
          color: MyColors.dark,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          filled: true,
          fillColor: MyColors.primary,
          hintText: label,
          hintStyle: const TextStyle(
            color: MyColors.secondary,
            fontFamily: 'LeagueGothic',
            fontSize: 32,
          ),
          suffixIcon: suffixIcon,
          label: Text(label),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.dark),
          ),
          floatingLabelStyle: const TextStyle(
            fontFamily: 'Poppins',
            color: MyColors.dark,
          ),
          errorStyle: const TextStyle(
            fontFamily: 'Poppins',
            color: MyColors.tertiary,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Isikan $label';
          }
          return null;
        },
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
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
          color: MyColors.secondary,
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
