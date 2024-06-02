import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class BuktiPembayaranScreen extends StatefulWidget {
  const BuktiPembayaranScreen({super.key});

  @override
  State<BuktiPembayaranScreen> createState() => _BuktiPembayaranScreenState();
}

class _BuktiPembayaranScreenState extends State<BuktiPembayaranScreen> {
  File? _image;

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => _image = imageTemp);
    } on PlatformException catch (e) {
      print('failed to pick image: $e');
    }
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
                                    fontFamily: 'BebasNeue', fontSize: 38),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Pembelian Akun akan Segera Diproses oleh Penjual",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'BebasNeue', fontSize: 28),
                              ),
                              const SizedBox(height: 25),
                              MyButton(
                                text: "Ke Halaman Riwayat",
                                onPressed: () {
                                  Navigator.of(
                                    dialogContext,
                                    rootNavigator: true,
                                  ).pop();
                                },
                                color: const Color(0xFFFFC639),
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
          ],
        ),
      ),
    );
  }

  void openModalOption(BuildContext context) {
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
