import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/account_games/model/game_model.dart';
import 'package:jbag/src/features/admin/game/admin_detail_game.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jbag/src/constants/api_constants.dart';

class AdminDaftarGame extends StatefulWidget {
  const AdminDaftarGame({super.key});

  @override
  State<AdminDaftarGame> createState() => _AdminDaftarGameState();
}

class _AdminDaftarGameState extends State<AdminDaftarGame> {
  late Future<List<GameModel>> _futureGames;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeGames();
  }

  void _initializeGames() async {
    try {
      _futureGames = getGames();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print('Error: $e');
      // Mengembalikan Future yang error agar tidak mengganggu eksekusi FutureBuilder atau pemanggilan lainnya
      _futureGames = Future.error(e);
    }
  }

  Future<List<GameModel>> getGames() async {
    final response = await http.get(Uri.parse('$apiEndPoint/games/'));
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseBody['success'] == false) {
        throw Exception(responseBody['message']);
      }
      final data = responseBody['data'];

      List<GameModel> games = GameModel.fromApiResponseList(data);

      return games;
    } else {
      throw Exception('Failed to load games');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF131A2A),
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: MyColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Daftar Game',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'BebasNeue',
            color: Color(0xFFFFFAFF),
            fontSize: 42,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: FutureBuilder(
          future: _futureGames,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(color: MyColors.white);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final List<GameModel> listGames = snapshot.data!;
              return ListView.builder(
                itemCount: listGames.length,
                itemBuilder: (BuildContext context, int index) {
                  GameModel game = listGames[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    color: const Color(0xFFFFC639),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            game.nama!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontFamily: 'BebasNeue',
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.edit, color: Colors.black),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminDetailGame(
                              id: game.id!,
                              nama: game.nama!,
                              icon: game.icon!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambahkan logika untuk menambah game baru
        },
        backgroundColor: MyColors.accent,
        child: Icon(Icons.add, color: MyColors.dark),
      ),
    );
  }
}
