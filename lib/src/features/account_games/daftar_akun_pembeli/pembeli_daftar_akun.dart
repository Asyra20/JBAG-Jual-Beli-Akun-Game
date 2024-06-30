import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/features/account_games/model/game_model.dart';
import 'package:jbag/src/features/account_games/model/akun_game_model.dart';
import 'package:jbag/src/features/account_games/controller/game_controller.dart';
import 'package:jbag/src/features/account_games/daftar_akun_pembeli/kartu_akun_game.dart';
import 'package:jbag/src/features/account_games/daftar_akun_pembeli/pembeli_sidebar.dart';
import 'package:jbag/src/features/account_games/daftar_akun_pembeli/pembeli_detail_akun.dart';

class PembeliDaftarAkunGame extends StatefulWidget {
  const PembeliDaftarAkunGame({super.key});

  @override
  State<PembeliDaftarAkunGame> createState() => _DaftarAkunGameState();
}

class _DaftarAkunGameState extends State<PembeliDaftarAkunGame> {
  final GameController _gameController = GameController();
  late Future<List<AkunGameModel>> _futureSearch;
  Future<List<GameModel>>? _futureGames;

  final TextEditingController _search = TextEditingController();

  int? _selectedGameId;

  List<AkunGameModel> _akunGames = [];

  @override
  void initState() {
    super.initState();
    _futureSearch = cari(gameId: null, judul: null);
    _futureGames = _gameController.getGames();
  }

  Future<List<AkunGameModel>> cari({
    int? gameId,
    String? judul,
  }) async {
    final queryParams = {
      if (gameId != null && gameId != 0) 'game_id': gameId.toString(),
      if (judul != null) 'judul': judul,
    };

    final uri = Uri.parse('$apiEndPoint/akungame/search')
        .replace(queryParameters: queryParams);
    final response = await http.get(uri);
    final responseBody = json.decode(response.body);

    try {
      if (response.statusCode == 200) {
        if (responseBody['sukses'] == false) {
          throw Exception('Gagal memuat akun games');
        }

        final data = responseBody['data'];

        return AkunGameModel.fromApiResponseList(data);
      } else {
        throw Exception('Gagal memuat akun games');
      }
    } catch (e) {
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
          preferredSize: Size.fromHeight(70),
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
              future: _futureGames,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(color: MyColors.white);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final List<GameModel> listGames = snapshot.data!;

                  return DropdownMenu(
                    initialSelection: 0,
                    expandedInsets: EdgeInsets.zero,
                    menuStyle: MenuStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      shape: WidgetStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                      maximumSize:
                          const WidgetStatePropertyAll(Size.fromHeight(250)),
                    ),
                    inputDecorationTheme: const InputDecorationTheme(
                      constraints: BoxConstraints(maxHeight: 50),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      filled: true,
                      fillColor: MyColors.dark,
                      border: InputBorder.none,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 32,
                      fontFamily: 'LeagueGothic',
                      color: MyColors.white,
                    ),
                    enableSearch: false,
                    dropdownMenuEntries: listGames
                        .map(
                          (e) => DropdownMenuEntry(
                            label: e.nama!,
                            value: e.id!,
                            style: MenuItemButton.styleFrom(
                              backgroundColor: MyColors.white,
                              textStyle: const TextStyle(
                                fontSize: 32,
                                fontFamily: 'LeagueGothic',
                                color: MyColors.dark,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onSelected: (value) {
                      setState(() {
                        _selectedGameId = value;
                        _futureSearch =
                            cari(gameId: _selectedGameId, judul: _search.text);
                      });
                    },
                  );
                }
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
                        child: Text('Tidak ada akun game ditemukan',
                            style: TextStyle(color: MyColors.white)));
                  } else {
                    _akunGames = snapshot.data!;

                    return ListView.builder(
                      itemCount: _akunGames.length,
                      itemBuilder: (context, index) {
                        AkunGameModel akunGame = _akunGames[index];

                        return KartuAkunGame(
                          imageUrl: '$baseUrl/${akunGame.gambar!}',
                          title: akunGame.judul!,
                          price: akunGame.harga!.toString(),
                          logoUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhoUjcDjDw_TMXthjcyBqcDzmvVEOFc1KZ3Zwuum3Bawyot5g8bXdILcAMF2Eb8MLYAJr1vscCS-fec8sIyqj_1tMTJ5KZjPwodKhXyqaEBcCNKwoUcpPNpM5wL68NXOHFto8cHaW3lrFBc/s2048/mlbb+old-01.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PembeliDetailAkun(
                                  akunGameDetail: akunGame,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
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
