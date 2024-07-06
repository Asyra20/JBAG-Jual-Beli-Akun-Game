import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/auth/login_screen.dart';

class RegistrasiPembeli extends StatelessWidget {
  const RegistrasiPembeli({super.key});

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
        title: const Text(
          "Registrasi Pembeli",
          style: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: 42,
            color: MyColors.white,
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

  void _clearForm() {
    setState(() {
      _namaController.clear();
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
    });
  }

  @override
  void dispose() {
    _namaController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  mainAxisSize: MainAxisSize.max,
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
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyButtonForm(
                          label: "SUBMIT",
                          color: const Color(0xFFFFC639),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              try {
                                registrasi(
                                  _namaController.text,
                                  _usernameController.text,
                                  _emailController.text,
                                  _passwordController.text,
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
          ),
        ],
      ),
    );
  }

  Future<void> registrasi(
      String nama, String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiEndPoint/register-user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nama': nama,
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      if (data['success'] == false) {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Gagal registrasi');
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
        cursorColor: MyColors.dark,
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
