import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/features/reuseable_component/pembeli_sidebar.dart';

class ProfilPembeli extends StatelessWidget {
  const ProfilPembeli({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const PembeliSidebar(),
      backgroundColor: Color(0xFF131A2A),
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
      body: ProfilPembeliBody(),
    );
  }
}

class ProfilPembeliBody extends StatefulWidget {
  const ProfilPembeliBody({super.key});

  @override
  State<ProfilPembeliBody> createState() => _ProfilPembeliBodyState();
}

class _ProfilPembeliBodyState extends State<ProfilPembeliBody> {
  final _formKey = GlobalKey<FormState>();

  bool _isEditable = false;

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();

  final String _initNama = 'Dzaky';
  final String _initUsername = '';
  final String _initEmail = '';
  final String _initPassword = '';
  final String _initNoTelp = '';

  @override
  void initState() {
    _namaController.text = _initNama;
    _usernameController.text = _initUsername;
    _emailController.text = _initEmail;
    _passwordController.text = _initPassword;
    _noTelpController.text = _initNoTelp;
    super.initState();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _noTelpController.dispose();
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
                      'Profil Pembeli',
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Data akan diedit"),
                                  ),
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
                                _namaController.text = _initNama;
                                _usernameController.text = _initUsername;
                                _emailController.text = _initEmail;
                                _passwordController.text = _initPassword;
                                _noTelpController.text = _initNoTelp;

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
