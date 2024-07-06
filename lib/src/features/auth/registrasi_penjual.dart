import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/auth/login_screen.dart';

class RegistrasiPenjual extends StatelessWidget {
  const RegistrasiPenjual({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.dark,
      appBar: AppBar(
        backgroundColor: MyColors.dark,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: MyColors.white,
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
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _namaProfilEwalletController =
      TextEditingController();
  final TextEditingController _noEwalletController = TextEditingController();
  final TextEditingController _fotoktpController = TextEditingController();

  int? _selectedEwalletId;
  List<EwalletModel> _listEwallet = [];
  late Future<void> _futureEwallets;

  File? _image;

  @override
  void initState() {
    super.initState();
    _futureEwallets = getEwallets();
  }

  Future<void> getEwallets() async {
    final response = await http.get(Uri.parse('$apiEndPoint/ewallets'));
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseBody['success'] == false) {
        throw Exception(responseBody['message']);
      }
      final data = responseBody['data'];

      List<EwalletModel> ewallets = EwalletModel.fromApiResponseList(data);
      ewallets.insert(
          0, EwalletModel(id: 0, nama: "Pilih Ewallet", icon: null));

      setState(() {
        _listEwallet = ewallets;
      });
    } else {
      throw Exception('Failed to load ewallets');
    }
  }

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      String fileName = imageTemp.path.split('/').last;

      setState(() {
        _image = imageTemp;
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
      _selectedEwalletId = 0;
    });
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
    _selectedEwalletId = null;
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
                  color: MyColors.white,
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
                label: "Deskripsi",
                isReadOnly: false,
                controller: _alamatController,
                inputType: TextInputType.multiline,
                maxLines: 3,
              ),
              MyTextField(
                label: "Foto KTP + Muka",
                isReadOnly: true,
                controller: _fotoktpController,
                inputType: TextInputType.text,
                suffixIcon: IconButton(
                  padding: const EdgeInsets.only(right: 8.0),
                  icon: const FaIcon(FontAwesomeIcons.fileImport, size: 32),
                  onPressed: () {
                    openModalOption(context);
                  },
                ),
              ),
              FutureBuilder(
                future: _futureEwallets,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator(color: MyColors.white));
                  }

                  if (_listEwallet.isEmpty) {
                    return const Center(
                      child: Text(
                        'Ewallet kosong',
                        style: TextStyle(
                          fontFamily: 'LeagueGothic',
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                    );
                  }

                  return MyDropdown(
                    listEwallet: _listEwallet,
                    onSelected: (value) {
                      setState(() {
                        _selectedEwalletId = value;
                      });
                    },
                    selectedEwallet: _selectedEwalletId,
                  );
                },
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
                    color: MyColors.accent,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                          registrasiPenjual(
                            _namaController.text,
                            _usernameController.text,
                            _emailController.text,
                            _passwordController.text,
                            _noTelpController.text,
                            _alamatController.text,
                            _image,
                            _selectedEwalletId,
                            _namaProfilEwalletController.text,
                            _noEwalletController.text,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );

                          return;
                        }

                        _showLoginConfirmationDialog(context);
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  MyButtonForm(
                    label: "CLEAR",
                    color: MyColors.tertiary,
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
              tileColor: MyColors.primary,
              leading: const FaIcon(FontAwesomeIcons.camera),
              title: const Text('Camera'),
              onTap: () {
                getImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: MyColors.primary,
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

  void _showLoginConfirmationDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MyColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "PEMBERITAHUAN",
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 24,
                    color: MyColors.dark,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "REGISTRASI BERHASIL!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 18,
                    color: MyColors.dark,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.accent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        "LOGIN!",
                        style: TextStyle(
                          color: MyColors.dark,
                          fontFamily: 'BebasNeue',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.tertiary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "NAH!",
                        style: TextStyle(
                          color: MyColors.dark,
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

  Future<void> registrasiPenjual(
    String nama,
    String username,
    String email,
    String password,
    String notelp,
    String alamat,
    File? image,
    int? ewalletId,
    String namaProfilEwallet,
    String noEwallet,
  ) async {
    final url = Uri.parse('$apiEndPoint/register-penjual');

    final request = http.MultipartRequest('POST', url);
    request.fields['nama'] = nama;
    request.fields['username'] = username;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['no_telp'] = notelp;
    request.fields['alamat'] = alamat;
    request.files.add(await http.MultipartFile.fromPath('foto', image!.path));
    request.fields['ewallet_id'] = ewalletId!.toString();
    request.fields['nama_profil_ewallet'] = namaProfilEwallet;
    request.fields['nomor_ewallet'] = noEwallet;

    final response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = await http.Response.fromStream(response);
      final responseDataDecoded = json.decode(responseData.body);

      if (responseDataDecoded['success'] == false) {
        throw Exception(responseDataDecoded['message']);
      }
    } else {
      throw Exception('Gagal Registrasi Penjual');
    }
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
        foregroundColor: MyColors.dark,
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
          border: InputBorder.none,
          errorStyle: const TextStyle(
            fontFamily: 'Poppins',
            color: MyColors.tertiary,
          ),
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
  final List<EwalletModel> listEwallet;
  final ValueChanged<int?> onSelected;
  final int? selectedEwallet;

  const MyDropdown({
    super.key,
    required this.listEwallet,
    required this.onSelected,
    required this.selectedEwallet,
  });

  @override
  Widget build(BuildContext context) {
    print("selectedEwallet");
    print(selectedEwallet);

    return (listEwallet.isNotEmpty
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownMenu<int>(
              label: selectedEwallet != 0 && selectedEwallet != null
                  ? Image.network(
                      "$baseUrl/${listEwallet.firstWhere((element) => element.id == selectedEwallet).icon!}",
                      height: 40,
                    )
                  : const Text(
                      "Jenis e-Wallet",
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'LeagueGothic',
                        color: MyColors.dark,
                      ),
                    ),
              expandedInsets: EdgeInsets.zero,
              menuStyle: MenuStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero),
                shape: WidgetStateProperty.all(
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                constraints: BoxConstraints(maxHeight: 50),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 6),
                filled: true,
                fillColor: MyColors.primary,
                border: InputBorder.none,
              ),
              textStyle: const TextStyle(
                fontSize: 32,
                fontFamily: 'LeagueGothic',
                color: MyColors.dark,
              ),
              enableSearch: false,
              dropdownMenuEntries: listEwallet
                  .map(
                    (e) => DropdownMenuEntry<int>(
                      label: '',
                      value: e.id!,
                      leadingIcon: e.icon != null
                          ? Image.network(
                              "$baseUrl/${e.icon!}",
                              height: 40,
                              alignment: Alignment.centerLeft,
                            )
                          : Text(
                            e.nama!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'LeagueGothic',
                              color: MyColors.dark,
                            ),
                          ),
                      style: MenuItemButton.styleFrom(  
                        backgroundColor: MyColors.primary,
                        textStyle: const TextStyle(
                          fontSize: 32,
                          fontFamily: 'LeagueGothic',
                          color: MyColors.dark,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onSelected: onSelected,
            ),
          )
        : Container());
  }
}

class EwalletModel {
  int? id;
  String? nama;
  String? icon;

  EwalletModel({
    required this.id,
    required this.nama,
    required this.icon,
  });

  EwalletModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nama = json["nama"];
    icon = json["icon"];
  }

  static List<EwalletModel> fromApiResponseList(List<dynamic> jsonList) {
    return jsonList.map((json) => EwalletModel.fromJson(json)).toList();
  }
}
