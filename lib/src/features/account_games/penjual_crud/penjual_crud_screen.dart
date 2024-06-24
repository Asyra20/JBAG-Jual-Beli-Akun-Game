import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jbag/src/features/account_games/daftar_akun_penjual/sidebar_game_penjual.dart';

class TambahAkunGame extends StatelessWidget {
  const TambahAkunGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF131A2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131A2A),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.bars,
                color: Color(0xFFFFFAFF),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: const TambahAkunGameBody(),
    );
  }
}

class TambahAkunGameBody extends StatefulWidget {
  const TambahAkunGameBody({super.key});

  @override
  State<TambahAkunGameBody> createState() => _TambahAkunGameBodyState();
}

class _TambahAkunGameBodyState extends State<TambahAkunGameBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _gambarController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  String? _selectedGame;

  final List<String> _listGames = ["Mobile Legends", "PUBG", "Free Fire"];

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      String fileName = imageTemp.path.split('/').last;

      setState(() {
        _gambarController.text = fileName;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _clearForm() {
    setState(() {
      _judulController.clear();
      _hargaController.clear();
      _gambarController.clear();
      _deskripsiController.clear();
      _selectedGame = null;
    });
  }

  @override
  void dispose() {
    _judulController.dispose();
    _hargaController.dispose();
    _gambarController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const Text(
              'Tambah Akun Game',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'BebasNeue',
                fontSize: 50,
                color: Color(0xFFFFFAFF),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFFFC639), width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedGame,
                dropdownColor: const Color(0xFF131A2A),
                onChanged: (newValue) {
                  setState(() {
                    _selectedGame = newValue;
                  });
                },
                decoration: const InputDecoration(
                  filled: false,
                  border: InputBorder.none,
                ),
                icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFFFC639)),
                hint: const Text(
                  "Pilih Game",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'LeagueGothic',
                    color: Colors.white,
                  ),
                ),
                items: _listGames.map((String game) {
                  return DropdownMenuItem<String>(
                    value: game,
                    child: Text(
                      game,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'LeagueGothic',
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            MyTextField(
              label: "Judul",
              isReadOnly: false,
              controller: _judulController,
              inputType: TextInputType.text,
            ),
            MyTextField(
              label: "Harga",
              isReadOnly: false,
              controller: _hargaController,
              inputType: TextInputType.number,
            ),
            MyTextField(
              label: "Gambar",
              isReadOnly: true,
              controller: _gambarController,
              inputType: TextInputType.text,
              suffixIcon: IconButton(
                padding: const EdgeInsets.only(right: 8.0),
                icon: const FaIcon(FontAwesomeIcons.fileImport, size: 32),
                onPressed: () {
                  openModalOption(context);
                },
              ),
            ),
            MyTextField(
              label: "Deskripsi",
              isReadOnly: false,
              controller: _deskripsiController,
              inputType: TextInputType.multiline,
              maxLines: 3,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButtonForm(
                  label: "BATAL",
                  color: Colors.red,
                  onPressed: _clearForm,
                ),
                MyButtonForm(
                  label: "TAMBAH",
                  color: const Color(0xFFFFC639),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Form Submitted"),
                        ),
                      );
                    }
                  },
                ),
              ],
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

class MyButtonForm extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const MyButtonForm({
    super.key,
    required this.label,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: const Color(0xFF131A2A),
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        textStyle: const TextStyle(
          fontSize: 32,
          fontFamily: 'BebasNeue',
        ),
      ),
      child: Text(label),
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
        cursorColor: const Color(0xFF131A2A),
        maxLines: maxLines ?? 1,
        style: const TextStyle(
          fontSize: 32,
          fontFamily: 'LeagueGothic',
          color: Color(0xFF131A2A),
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
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
