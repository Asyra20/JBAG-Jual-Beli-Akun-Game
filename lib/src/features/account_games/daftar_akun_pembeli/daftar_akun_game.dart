import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/account_games/controller/game_controller.dart';
import 'package:jbag/src/features/account_games/daftar_akun_pembeli/detail_akun_screen.dart';
import 'package:jbag/src/features/account_games/daftar_akun_pembeli/kartu_akun_game.dart';
import 'package:jbag/src/features/account_games/daftar_akun_pembeli/sidebar_game_pembeli.dart';
import 'package:jbag/src/features/account_games/model/akun_game_model.dart';
import 'package:jbag/src/features/account_games/model/game_model.dart';
import 'package:jbag/src/utils/json_printer.dart';

class DaftarAkunGame extends StatefulWidget {
  const DaftarAkunGame({super.key});

  @override
  State<DaftarAkunGame> createState() => _DaftarAkunGameState();
}

class _DaftarAkunGameState extends State<DaftarAkunGame> {
  final GameController _gameController = GameController();
  late Future<void> _future;
  late Future<List<AkunGameModel>> _futureSearch;

  final TextEditingController _search = TextEditingController();

  int? _selectedGameId;

  List<GameModel> _listGames = [];
  List<AkunGameModel> _akunGames = [];

  Future<void> _fetchGames() async {
    final items = await _gameController.getGames();
    setState(() {
      _listGames = [GameModel(id: 0, nama: "PilihGame", icon: null)] + items;
    });
  }

  @override
  void initState() {
    super.initState();
    _future = _fetchGames();
    _futureSearch = cari(gameId: null, judul: null);
  }

  Future<List<AkunGameModel>> cari({
    int? gameId,
    String? judul,
  }) async {
    final queryParams = {
      'game_id': (gameId != null && gameId != 0) ? gameId.toString() : null,
      'judul': (judul != null) ? judul : null,
    };

    final uri = Uri.parse('$apiEndPoint/akungame/search')
        .replace(queryParameters: queryParams);
    final response = await http.get(uri);
    final responseBody = json.decode(response.body);

    try {
      print(JsonPrinter.prettyPrint(responseBody));
      if (response.statusCode == 200) {
        if (responseBody['success'] == false) {
          throw Exception('Failed to load akun games');
        }

        final data = responseBody['data'];

        return AkunGameModel.fromApiResponseList(data);
      } else {
        throw Exception('Failed to load akun games');
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );

      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: MyColors.white, size: 35),
        backgroundColor: MyColors.dark,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(70), // Tinggi teks "Daftar Akun Games"
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Daftar Akun Games',
              style: TextStyle(
                fontFamily: 'LeagueGothic',
                color: MyColors.white,
                fontSize: 50,
              ),
            ),
          ),
        ),
      ),
      drawer: const SidebarGamePembeli(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                return DropdownButtonFormField<int>(
                  value: _selectedGameId,
                  dropdownColor: MyColors.dark,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGameId = newValue!;
                      _futureSearch =
                          cari(gameId: _selectedGameId, judul: _search.text);
                    });
                  },
                  decoration: const InputDecoration(
                    filled: false,
                    border: InputBorder.none,
                  ),
                  icon:
                      const Icon(Icons.arrow_drop_down, color: MyColors.accent),
                  hint: const Text(
                    "Pilih Game",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'LeagueGothic',
                      color: MyColors.white,
                    ),
                  ),
                  items: _listGames.map((GameModel game) {
                    return DropdownMenuItem<int>(
                      value: game.id,
                      child: Text(
                        game.nama!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'LeagueGothic',
                          color: MyColors.white,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _search,
              decoration: InputDecoration(
                filled: true,
                fillColor: MyColors.dark,
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.accent),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: MyColors.white),
                  onPressed: () {
                    setState(() {
                      _futureSearch =
                          cari(gameId: _selectedGameId, judul: _search.text);
                    });
                  },
                ),
              ),
              style: const TextStyle(color: MyColors.white),
              cursorColor: MyColors.white,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder(
                future: _futureSearch,
                builder: (context, snapshot) {
                  print("Data snapshot");
                  print(snapshot.data);

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator(color: MyColors.white));
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Error: ${snapshot.error}',
                            style: const TextStyle(color: MyColors.white)));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No akun games found',
                            style: TextStyle(color: MyColors.white)));
                  } else {
                    _akunGames = snapshot.data!;

                    return ListView.builder(
                        itemCount: _akunGames.length,
                        itemBuilder: (context, index) {
                          return KartuAkunGame(
                            imageUrl:
                                'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSpSxJS6iDjzpWTViuc1VovCyBT8tCz7Q7FBhGDhP5O-FMXMcK5',
                            title: 'AKUN RAWAT PRIBADI SULTAN',
                            price: 'Rp 5.000.000',
                            logoUrl:
                                'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhoUjcDjDw_TMXthjcyBqcDzmvVEOFc1KZ3Zwuum3Bawyot5g8bXdILcAMF2Eb8MLYAJr1vscCS-fec8sIyqj_1tMTJ5KZjPwodKhXyqaEBcCNKwoUcpPNpM5wL68NXOHFto8cHaW3lrFBc/s2048/mlbb+old-01.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DetailAkunScreen(
                                    imageUrl:
                                        'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSpSxJS6iDjzpWTViuc1VovCyBT8tCz7Q7FBhGDhP5O-FMXMcK5',
                                    title: 'AKUN RAWAT PRIBADI SULTAN',
                                    price: 'Rp 5.000.000',
                                  ),
                                ),
                              );
                            },
                          );
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
      backgroundColor: MyColors.dark,
    );
  }
}
