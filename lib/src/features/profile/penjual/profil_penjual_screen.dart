import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilPenjual extends StatelessWidget {
  const ProfilPenjual({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF131A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF131A2A),
        leading: IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.bars,
            color: Color(0xFFFFFAFF),
          ),
        ),
      ),
      body: ProfilPenjualBody(),
    );
  }
}

class ProfilPenjualBody extends StatefulWidget {
  const ProfilPenjualBody({super.key});

  @override
  State<ProfilPenjualBody> createState() => _ProfilPenjualBodyState();
}

class _ProfilPenjualBodyState extends State<ProfilPenjualBody> {
  final _formKey = GlobalKey<FormState>();
  _ProfilPembeliData _data = _ProfilPembeliData();

  bool _isEditable = false;

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _namaProfilEwalletController =
      TextEditingController();
  final TextEditingController _noEwalletController = TextEditingController();

  String _selectedEwallet = "";

  List<String> listEwallet = ["Gopay", "Dana", "OVO"];

  @override
  void initState() {
    _namaController.text = _data.nama;
    _usernameController.text = _data.username;
    _emailController.text = _data.email;
    _passwordController.text = _data.password;
    _noTelpController.text = _data.noTelp;
    _selectedEwallet = _data.jenisEwallet;
    _namaProfilEwalletController.text = _data.namaProfilEwallet;
    _noEwalletController.text = _data.noEwallet;
    super.initState();
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
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Profil Penjual',
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
                      isReadOnly: !_isEditable,
                      controller: _namaController,
                      inputType: TextInputType.text,
                    ),
                    MyTextField(
                      label: "Email",
                      isReadOnly: !_isEditable,
                      controller: _emailController,
                      inputType: TextInputType.emailAddress,
                    ),
                    MyTextField(
                      label: "Username",
                      isReadOnly: !_isEditable,
                      controller: _usernameController,
                      inputType: TextInputType.text,
                    ),
                    MyTextField(
                      label: "Password",
                      isReadOnly: !_isEditable,
                      controller: _passwordController,
                      inputType: TextInputType.text,
                    ),
                    MyTextField(
                      label: "Nomor Telepon",
                      isReadOnly: !_isEditable,
                      controller: _noTelpController,
                      inputType: TextInputType.number,
                    ),
                    MyDropdown(
                      initialSelection: _selectedEwallet,
                      listEwallet: listEwallet,
                      onSelected: (value) {
                        if (_isEditable) {
                          if (value != null) {
                            setState(() {
                              _selectedEwallet = value;
                            });
                          }
                        }
                      },
                    ),
                    MyTextField(
                      label: "Nama Profil pada e-Wallet",
                      isReadOnly: !_isEditable,
                      controller: _namaProfilEwalletController,
                      inputType: TextInputType.text,
                    ),
                    MyTextField(
                      label: "Nomor e-Wallet",
                      isReadOnly: !_isEditable,
                      controller: _noEwalletController,
                      inputType: TextInputType.text,
                    ),
                    const SizedBox(height: 50),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyButtonEditForm(
                            color: const Color(0xFFFFC639),
                            isEditable: _isEditable,
                            onPressed: () {
                              if (_isEditable) {
                                sumbit(
                                  _formKey,
                                  _namaController.text,
                                  _usernameController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                  _noTelpController.text,
                                  _selectedEwallet,
                                  _namaProfilEwalletController.text,
                                  _noEwalletController.text,
                                );
                              }
                              setState(() {
                                _isEditable = true;
                              });
                            },
                          ),
                          if (_isEditable)
                            MyButtonCancelForm(
                              color: const Color(0xFFF9564F),
                              isEditable: _isEditable,
                              onPressed: () {
                                _namaController.text = _data.nama;
                                _usernameController.text = _data.username;
                                _emailController.text = _data.email;
                                _passwordController.text = _data.password;
                                _noTelpController.text = _data.noTelp;
                                _selectedEwallet = _data.jenisEwallet;
                                _namaProfilEwalletController.text =
                                    _data.namaProfilEwallet;
                                _noEwalletController.text = _data.noEwallet;

                                setState(() {
                                  _isEditable = false;
                                });
                              },
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void sumbit(
  GlobalKey<FormState> formKey,
  String nama,
  String username,
  String email,
  String password,
  String noTelp,
  String selectedEwallet,
  String namaProfilEwallet,
  String noEwallet,
) {
  formKey.currentState?.save();
  print('Nama: $nama');
  print('Username: $username');
  print('Email: $email');
  print('Password: $password');
  print('Nomor Telepon: $noTelp');
  print('Jenis Ewallet: $selectedEwallet');
  print('Nama Profil Ewallet: $namaProfilEwallet');
  print('Nomor Ewallet: $noEwallet');
}

class MyDropdown extends StatelessWidget {
  final List<String> listEwallet;
  final ValueChanged onSelected;
  final String _initialSelection;

  const MyDropdown({
    super.key,
    required this.listEwallet,
    required this.onSelected,
    required String initialSelection,
  }) : _initialSelection = initialSelection;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownMenu(
        expandedInsets: EdgeInsets.zero,
        menuStyle: MenuStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          constraints: BoxConstraints(maxHeight: 50), // Size TextField
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 6),
          filled: true,
          fillColor: Color(0xFFECE8E1),
          hintStyle: TextStyle(
            color: Color(0xFF393E46),
            fontFamily: 'LeagueGothic',
            fontSize: 32,
          ),
          border: InputBorder.none,
        ),
        hintText: "Jenis e-Wallet",
        textStyle: const TextStyle(
          fontSize: 32,
          fontFamily: 'LeagueGothic',
          color: Color(0xFF131A2A),
        ),
        enableSearch: false,
        initialSelection: _initialSelection,
        dropdownMenuEntries: listEwallet
            .map(
              (e) => DropdownMenuEntry(
                value: e,
                label: e,
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

class MyButtonEditForm extends StatelessWidget {
  final bool _isEditable;
  final VoidCallback onPressed;
  final Color color;

  const MyButtonEditForm({
    super.key,
    required bool isEditable,
    required this.onPressed,
    required this.color,
  }) : _isEditable = isEditable;

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
          color: Color(0xFF393E46),
        ),
      ),
      child: Text(_isEditable ? "Simpan" : "Edit"),
    );
  }
}

class MyButtonCancelForm extends StatelessWidget {
  final bool _isEditable;
  final VoidCallback onPressed;
  final Color color;

  const MyButtonCancelForm({
    super.key,
    required bool isEditable,
    required this.onPressed,
    required this.color,
  }) : _isEditable = isEditable;

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
          color: Color(0xFF393E46),
        ),
      ),
      child: Text(_isEditable ? "Batal" : ""),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String label;
  final bool isReadOnly;
  final TextEditingController controller;
  final TextInputType inputType;

  const MyTextField({
    super.key,
    required this.label,
    required this.isReadOnly,
    required this.controller,
    required this.inputType,
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
          border: InputBorder.none,
        ),
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      ),
    );
  }
}

class _ProfilPembeliData {
  String nama = 'Dzaky';
  String username = '';
  String email = '';
  String password = '';
  String noTelp = '';
  String jenisEwallet = 'Dana';
  String namaProfilEwallet = '';
  String noEwallet = '';
}
