import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilPembeli extends StatelessWidget {
  const ProfilPembeli({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
  bool _isEditable = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    isReadOnly: _isEditable,
                    controller: _nameController,
                    inputType: TextInputType.text,
                  ),
                  MyTextField(
                    label: "Email",
                    isReadOnly: _isEditable,
                    controller: _emailController,
                    inputType: TextInputType.emailAddress,
                  ),
                  MyTextField(
                    label: "Username",
                    isReadOnly: _isEditable,
                    controller: _usernameController,
                    inputType: TextInputType.text,
                  ),
                  MyTextField(
                    label: "Password",
                    isReadOnly: _isEditable,
                    controller: _passwordController,
                    inputType: TextInputType.text,
                  ),
                  MyTextField(
                    label: "Nomor Telepon",
                    isReadOnly: _isEditable,
                    controller: _phoneController,
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 50),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isEditable = !_isEditable;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFC639),
                        foregroundColor: Color(0xFF131A2A),
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        textStyle: TextStyle(
                          fontSize: 32,
                          fontFamily: 'BebasNeue',
                          color: Color(0xFF393E46),
                        ),
                      ),
                      child: Text(_isEditable ? 'EDIT' : 'SAVE'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
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
      child: TextField(
        keyboardType: inputType,
        readOnly: isReadOnly,
        controller: controller,
        obscureText: (label == "Password" ? true : false),
        cursorColor: const Color(0xFF131A2A),
        style: const TextStyle(
          fontSize: 32,
          fontFamily: 'LeagueGothic',
          color: Color(0xFF393E46),
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
