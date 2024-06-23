import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/features/cart/model/keranjang_item.dart';

class KeranjangController {

  final String _endpoint = '$baseUrl/api/keranjang';

  Future<List<KeranjangItem>> fetchKeranjang(int userId) async {
    final response =
        await http.get(Uri.parse('$_endpoint/user/$userId'));
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseBody['success'] == false) {
        throw Exception(responseBody['message']);
      }
      final data = responseBody['data'];
      return KeranjangItem.fromApiResponseList(data);
    } else {
      throw Exception('Failed to load keranjang');
    }
  }

  Future<String> addKeranjang(int userId, int akunGameId) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      body: json.encode({'user_id': userId, 'akun_game_id': akunGameId}),
    );
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseBody['success'] == false) {
        throw Exception(responseBody['message']);
      }

      return responseBody['message'];
    } else {
      throw Exception('Failed to add keranjang');
    }
  }

  Future<String> deleteKeranjang(int id) async {
    final response = await http.delete(Uri.parse('$_endpoint/$id'));
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseBody['success'] == false) {
        throw Exception(responseBody['message']);
      }

      return responseBody['message'];
    } else {
      throw Exception('Failed to delete keranjang');
    }
  }
}
