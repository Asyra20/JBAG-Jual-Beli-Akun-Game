import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jbag/src/features/auth/login_screen.dart';

class RegistrasiPenjual extends StatelessWidget {
  const RegistrasiPenjual({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF131A2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131A2A),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Color(0xFFFFFAFF),
          ),
        ),
      ),
      body: const RegistrasiPenjualBody(),
    );
  }
}

class RegistrasiPenjualBody extends StatefulWidget {
  const RegistrasiPenjualBody({super.key});

  @override
  State<RegistrasiPenjualBody> createState() => _RegistrasiPenjualBodyState();
}

class _RegistrasiPenjualBodyState extends State<RegistrasiPenjualBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _namaProfilEwalletController = TextEditingController();
  final TextEditingController _noEwalletController = TextEditingController();
  final TextEditingController _fotoktpController = TextEditingController();

  String? _selectedEwallet;

  final List<Map<String, String>> _listEwallet = [
    {"label": "Dana", "icon": "assets/logo/logo-dana.png"},
    {"label": "GOPAY", "icon": "assets/logo/logo-gopay.png"},
    {"label": "OVO", "icon": "assets/logo/logo-ovo.png"},
  ];

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      String fileName = imageTemp.path.split('/').last;

      setState(() {
        _fotoktpController.text = fileName;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _clearForm() {
    setState(() {
      _namaController.clear();
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _noTelpController.clear();
      _namaProfilEwalletController.clear();
      _noEwalletController.clear();
      _fotoktpController.clear();
      _selectedEwallet = null;
    });
  }

  void _showLoginConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFECE8E1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "PEMBERITAHUAN",
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 24,
                    color: Color(0xFF131A2A),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "REGISTRASI BERHASIL!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 18,
                    color: Color(0xFF131A2A),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFC639),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        "LOGIN!",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'BebasNeue',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF9564F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "NAH!",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'BebasNeue',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _noTelpController.dispose();
    _namaProfilEwalletController.dispose();
    _noEwalletController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const Text(
                'Registrasi Penjual',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: 48,
                  color: Color(0xFFFFFAFF),
                ),
              ),
              const SizedBox(height: 20),
              MyTextField(
                label: "Nama",
                isReadOnly: false,
                controller: _namaController,
                inputType: TextInputType.text,
              ),
              MyTextField(
                label: "Username",
                isReadOnly: false,
                controller: _usernameController,
                inputType: TextInputType.text,
              ),
              MyTextField(
                label: "Email",
                isReadOnly: false,
                controller: _emailController,
                inputType: TextInputType.emailAddress,
              ),
              MyTextField(
                label: "Password",
                isReadOnly: false,
                controller: _passwordController,
                inputType: TextInputType.text,
              ),
              MyTextField(
                label: "Nomor Telepon",
                isReadOnly: false,
                controller: _noTelpController,
                inputType: TextInputType.number,
              ),
              MyTextField(
                label: "Foto KTP + Muka",
                isReadOnly: true,
                controller: _fotoktpController,
                inputType: TextInputType.text,
                suffixIcon: IconButton(
                  padding: EdgeInsets.only(right: 8.0),
                  icon: FaIcon(FontAwesomeIcons.fileImport, size: 32),
                  onPressed: () {
                    openModalOption(context);
                  },
                ),
              ),
              MyDropdown(
                listEwallet: _listEwallet,
                onSelected: (value) {
                  setState(() {
                    _selectedEwallet = value;
                  });
                },
                selectedEwallet: _selectedEwallet,
              ),
              MyTextField(
                label: "Nama Profil pada e-Wallet",
                isReadOnly: false,
                controller: _namaProfilEwalletController,
                inputType: TextInputType.text,
              ),
              MyTextField(
                label: "Nomor e-Wallet",
                isReadOnly: false,
                controller: _noEwalletController,
                inputType: TextInputType.number,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButtonForm(
                    label: "SUBMIT",
                    color: const Color(0xFFFFC639),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showLoginConfirmationDialog(context);
                      }
                    },
                  ),
                  const SizedBox(width: 20), // Add some space between the buttons
                  MyButtonForm(
                    label: "CLEAR",
                    color: Colors.red,
                    onPressed: _clearForm,
                  ),
                ],
              ),
            ],
          ),
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

  const MyTextField({
    super.key,
    required this.label,
    required this.isReadOnly,
    required this.controller,
    required this.inputType, 
    this.suffixIcon,
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

class MyDropdown extends StatelessWidget {
  final List<Map<String, String>> listEwallet;
  final ValueChanged<String?> onSelected;
  final String? selectedEwallet;

  const MyDropdown({
    super.key,
    required this.listEwallet,
    required this.onSelected,
    required this.selectedEwallet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownMenu(
        label: selectedEwallet != null 
            ? Image.asset(
                listEwallet.firstWhere((element) => element['label'] == selectedEwallet)['icon']!,
                height: 40,
              )
            : const Text("Jenis e-Wallet", style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'LeagueGothic',
                  color: Color(0xFF131A2A),
                )),
        expandedInsets: EdgeInsets.zero,
        menuStyle: MenuStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          constraints: BoxConstraints(maxHeight: 50),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 6),
          filled: true,
          fillColor: Color(0xFFECE8E1),
          border: InputBorder.none,
        ),
        textStyle: const TextStyle(
          fontSize: 32,
          fontFamily: 'LeagueGothic',
          color: Color(0xFF131A2A),
        ),
        enableSearch: false,
        dropdownMenuEntries: listEwallet
            .map(
              (e) => DropdownMenuEntry(
                label: '',
                value: e['label']!,
                leadingIcon: Image.asset(
                  e['icon']!,
                  height: 40,
                  alignment: Alignment.centerLeft,
                ),
                style: MenuItemButton.styleFrom(
                  backgroundColor: const Color(0xFFECE8E1),
                  textStyle: const TextStyle(
                    fontSize: 32,
                    fontFamily: 'LeagueGothic',
                    color: Color(0xFF131A2A),
                  ),
                ),
              ),
            )
            .toList(),
        onSelected: onSelected,
      ),
    );
  }
}
