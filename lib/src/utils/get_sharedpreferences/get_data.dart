import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>?> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userJson = prefs.getString('user');
  if (userJson != null) {
    return jsonDecode(userJson);
  }
  return null;
}

Future<Map<String, dynamic>?> getPenjual() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userJson = prefs.getString('penjual');
  if (userJson != null) {
    return jsonDecode(userJson);
  }
  return null;
}
