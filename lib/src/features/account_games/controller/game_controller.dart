import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/features/account_games/model/game_model.dart';

class GameController {
  Future<List<GameModel>> getGames() async {
    final response = await http.get(Uri.parse('$apiEndPoint/games/'));
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseBody['success'] == false) {
        throw Exception(responseBody['message']);
      }
      final data = responseBody['data'];

      List<GameModel> games = GameModel.fromApiResponseList(data);
      games.insert(0, GameModel(id: 0, nama: "Pilih Game", icon: null));

      return games;
    } else {
      throw Exception('Failed to load keranjang');
    }
  }
}
