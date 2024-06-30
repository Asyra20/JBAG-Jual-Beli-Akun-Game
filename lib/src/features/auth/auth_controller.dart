import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/features/account_games/daftar_akun_pembeli/pembeli_daftar_akun.dart';
import 'package:jbag/src/features/account_games/daftar_akun_penjual/penjual_daftar_akun.dart';
import 'package:jbag/src/features/admin/admin_homescreen.dart';
import 'package:jbag/src/features/auth/login_screen.dart';
import 'package:jbag/src/utils/json_printer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    print('tokennya: ');
    print(token);
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  Future<void> login(
    BuildContext context,
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$apiEndPoint/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success'] == false) {
        throw Exception(data['message']);
      }

      final dataResponse = data['data'];
      print(JsonPrinter.prettyPrint(dataResponse));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', dataResponse['token']);
      await prefs.setString('token_type', dataResponse['token_type']);
      await prefs.setString('user', jsonEncode(dataResponse['user']));
      if (dataResponse['penjual'] != null) {
        await prefs.setString('penjual', jsonEncode(dataResponse['penjual']));
      }

      String role = dataResponse['user']['role'];

      if (role == 'penjual') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PenjualDaftarAkun()),
        );
      } else if (role == 'pembeli') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PembeliDaftarAkunGame()),
        );
      } else if (role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminMenuScreen()),
        );
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout(BuildContext context) async {
    await _getToken();

    var res = await http.post(
      Uri.parse('$apiEndPoint/logout'),
      headers: _setHeaders(),
    );

    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('penjual');
      localStorage.remove('token');
      localStorage.remove('token_type');

      if (context.mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    }
  }
}
