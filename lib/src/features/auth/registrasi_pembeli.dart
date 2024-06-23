import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/features/auth/login_screen.dart';

class RegistrasiPembeli extends StatelessWidget {
  const RegistrasiPembeli({super.key});

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
      body: const RegistrasiPembeliBody(),
    );
  }
}

class RegistrasiPembeliBody extends StatefulWidget {
  const RegistrasiPembeliBody({super.key});

  @override
  State<RegistrasiPembeliBody> createState() => _RegistrasiPembeliBodyState();
}

class _RegistrasiPembeliBodyState extends State<RegistrasiPembeliBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();

  void _clearForm() {
    setState(() {
      _namaController.clear();
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _noTelpController.clear();
    });
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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    const Text(
                      'Registrasi Pembeli',
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
                    const SizedBox(height: 50),
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
          ),
        ],
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 48),
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
          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
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
