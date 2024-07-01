import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/constants/api_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/features/account_games/model/akun_game_model.dart';
import 'package:jbag/src/features/account_games/penjual/penjual_kirim_akun.dart';
import 'package:jbag/src/features/reuseable_component/penjual_sidebar.dart';
import 'package:jbag/src/features/account_games/penjual/dialog_penilaian.dart';
import 'package:jbag/src/features/account_games/penjual/penjual_detail_akun.dart';

class PenjualDaftarAkun extends StatefulWidget {
  const PenjualDaftarAkun({super.key});

  @override
  State<PenjualDaftarAkun> createState() => _DaftarAkunScreenState();
}

class _DaftarAkunScreenState extends State<PenjualDaftarAkun>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _activeTabIndex = 0;
  late Future<List<AkunGameModel>> futureAkunGames;
  List<AkunGameModel> listAkunGame = [];

  final int idPenjual = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    futureAkunGames = fetchAkunGames(getStatusFromIndex(_activeTabIndex));
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _activeTabIndex = _tabController.index;
        futureAkunGames = fetchAkunGames(getStatusFromIndex(_activeTabIndex));
      });
    }
  }

  String getStatusFromIndex(int index) {
    switch (index) {
      case 0:
        return 'tersedia';
      case 1:
        return 'pending';
      case 2:
        return 'terjual';
      default:
        return 'tersedia';
    }
  }

  Future<List<AkunGameModel>> fetchAkunGames(String status) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/akungame/penjual/$idPenjual?status=$status'),
    );
    final responseBody = json.decode(response.body);

    try {
      if (response.statusCode == 200) {
        if (responseBody['success'] == false) {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: const CustomDrawer(),
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF131A2A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF131A2A),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.bars,
                  color: Color(0xFFFFFAFF),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        body: Column(
          children: [
            const Text(
              'Daftar Akun',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'BebasNeue',
                fontSize: 50,
                color: Color(0xFFFFFAFF),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: const Color(0xFFFFC639),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.red,
                labelColor: const Color(0xFF131A2A),
                unselectedLabelColor: const Color(0xFF131A2A),
                tabs: const [
                  Tab(text: 'Dijual'),
                  Tab(text: 'Pending'),
                  Tab(text: 'Terjual'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  buildAkunGameList(futureAkunGames, 'tersedia'),
                  buildAkunGameList(futureAkunGames, 'pending'),
                  buildAkunGameList(futureAkunGames, 'terjual'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAkunGameList(
      Future<List<AkunGameModel>> futureAkunGames, String status) {
    return FutureBuilder<List<AkunGameModel>>(
      future: futureAkunGames,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: MyColors.white));
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: MyColors.white)));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text('No akun games found',
                  style: TextStyle(color: MyColors.white)));
        } else {
          
          listAkunGame = snapshot.data!;

          return ListView.builder(
            itemCount: listAkunGame.length,
            itemBuilder: (context, index) {
              AkunGameModel akunGame = listAkunGame[index];

              return GestureDetector(
                onTap: () {
                  if (status == "tersedia") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PenjualDetailAkun(
                          akunGame: akunGame,
                        ),
                      ),
                    );
                  } else if (status == "pending") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PenjualKirimAkun(
                          transaksiId: akunGame.id!,
                        ),
                      ),
                    );
                  } else if (status == "terjual") {}
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  color: Colors.grey[800],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Image.network(
                          '$baseUrl/${akunGame.gambar!}',
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                                'assets/logo/logo-splash.png'); // Ganti dengan path gambar default-mu
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              akunGame.judul!,
                              style: const TextStyle(
                                  color: MyColors.accent,
                                  fontSize: 18,
                                  fontFamily: 'BebasNeue'),
                            ),
                          ),
                          Text(
                            akunGame.harga!.toString(),
                            style: const TextStyle(
                                color: MyColors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (status == "terjual")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Terjual tanggal',
                              style: TextStyle(
                                  color: MyColors.white,
                                  fontSize: 14,
                                  fontFamily: 'BebasNeue'),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "soldDate",
                                  style: TextStyle(
                                      color: MyColors.white,
                                      fontSize: 14,
                                      fontFamily: 'BebasNeue'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    backgroundColor: const Color(0xFFFFC639),
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const DialogPenilaian();
                                      },
                                    );
                                  },
                                  child: const Text(
                                    'LIHAT NILAI',
                                    style: TextStyle(
                                        fontFamily: 'BebasNeue', fontSize: 24),
                                  ),
                                ),
                              ],
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
      },
    );
  }
}
