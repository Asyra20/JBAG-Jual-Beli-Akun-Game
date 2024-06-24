import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/account_games/riwayat.dart';
import 'package:jbag/src/utils/json_printer.dart';

class BuktiPembayaranScreen extends StatefulWidget {
  final int _transaksiId;
  final bool _isPaid;

  const BuktiPembayaranScreen({
    super.key,
    required int transaksiId,
    required bool isPaid,
  })  : _transaksiId = transaksiId,
        _isPaid = isPaid;

  @override
  State<BuktiPembayaranScreen> createState() => _BuktiPembayaranScreenState();
}

class _BuktiPembayaranScreenState extends State<BuktiPembayaranScreen> {
  File? _image;
  String? url;

  Future<String> getImageNetwork(BuildContext context, int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/transaksi/$id/bukti-pembayaran'));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['success'] == true) {
          print("urlnya: ");
          print(JsonPrinter.prettyPrint(responseBody['data']));
          url = responseBody['data']["bukti_pembayaran"];

          return url!;
        } else {
          throw Exception(
              'Failed to fetch detail transaksi: ${responseBody['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch detail transaksi: ${response.reasonPhrase}');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }

    return "";
  }

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => _image = imageTemp);
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('failed to pick image: $e');
    }
  }

  Future<bool> _isFileSizeValid(File image) async {
    final fileSize = await image.length();
    return fileSize <= 10240 * 1024; // 10MB in bytes
  }

  Future<bool> uploadImage(File imageFile, int id) async {
    final url = Uri.parse('$baseUrl/api/transaksi/update/$id');

    final request = http.MultipartRequest('POST', url)
      ..fields['status_pembayaran'] = 'proses_bayar'
      ..files.add(await http.MultipartFile.fromPath(
          'bukti_pembayaran', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      final responseDataDecoded = json.decode(responseData.body);
      if (responseDataDecoded['success'] == true) {
        return true;
      }

      return false;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _image = null;
    url = "";
  }

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
              const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bukti Pembayaran',
                    style: TextStyle(
                      fontFamily: 'BebasNeue',
                      fontSize: 48,
                      color: Color(0xFFFFFAFF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (widget._isPaid)
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 450,
                        decoration: const BoxDecoration(
                          color: Color(0xFFECE8E1),
                        ),
                        child: FutureBuilder(
                          future: getImageNetwork(context, widget._transaksiId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: MyColors.dark),
                              );
                            }

                            return Image.network(
                              '$baseUrl/${snapshot.data!}',
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              filterQuality: FilterQuality.medium,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              else
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 450,
                        decoration: const BoxDecoration(
                          color: Color(0xFFECE8E1),
                        ),
                        child: _image == null
                            ? Center(
                                child: IconButton(
                                  onPressed: () {
                                    openModalOption(context);
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.fileImport,
                                    size: 80,
                                  ),
                                ),
                              )
                            : Image.file(
                                _image!,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                filterQuality: FilterQuality.medium,
                              ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget._isPaid
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyButton(
                      text: "Batal",
                      color: const Color(0xFFF9564F),
                      onPressed: () => setState(() {
                        _image = null;
                      }),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: MyButton(
                      text: "Upload",
                      color: const Color(0xFFFFC639),
                      onPressed: () async {
                        BuildContext dialogContext;

                        if (await _isFileSizeValid(_image!) == false) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Ukuran file lebih dari 10MB.'),
                              ),
                            );
                          }
                        } else {
                          bool isUploaded =
                              await uploadImage(_image!, widget._transaksiId);

                          if (context.mounted) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                dialogContext = context;
                                return dialogConfirm(dialogContext, isUploaded);
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Dialog dialogConfirm(BuildContext dialogContext, bool isUploaded) {
    String pesan;
    if (isUploaded) {
      pesan = "Pesanan akan segera diproses";
    } else {
      pesan = "ada kesalahan dalam upload file";
    }

    return Dialog(
      backgroundColor: const Color(0xFFECE8E1),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
            Text(
              pesan,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'BebasNeue',
                fontSize: 28,
                color: Color(0xFF131A2A),
              ),
            ),
            const SizedBox(height: 25),
            MyButton(
              text: isUploaded ? "Ke Halaman Riwayat" : "Kembali",
              onPressed: () {
                if (isUploaded) {
                  Navigator.of(dialogContext).push(MaterialPageRoute(
                    builder: (context) => const RiwayatScreen(),
                  ));
                } else {
                  Navigator.of(
                    dialogContext,
                    rootNavigator: true,
                  ).pop();
                }
              },
              color: const Color(0xFFFFC639),
            )
          ],
        ),
      ),
    );
  }

  void openModalOption(BuildContext context) {
    if (widget._isPaid) {}
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              tileColor: const Color(0xFFECE8E1),
              leading: const FaIcon(FontAwesomeIcons.camera),
              title: const Text('Camera'),
              onTap: () {
                getImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: const Color(0xFFECE8E1),
              leading: const FaIcon(FontAwesomeIcons.solidImage),
              title: const Text('Gallery'),
              onTap: () {
                getImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
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
