import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/account_games/daftar_akun_pembeli/sidebar_game_pembeli.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/features/transaction/model/riwayat_pembelian_model.dart';
import 'package:jbag/src/features/transaction/detail_transaksi.dart';

class DaftarAkunScreen extends StatefulWidget {
  const DaftarAkunScreen({super.key});

  @override
  State<DaftarAkunScreen> createState() => _DaftarAkunScreenState();
}

class _DaftarAkunScreenState extends State<DaftarAkunScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _activeTabIndex = 0;
  late Future<List<RiwayatPembelianModel>> futureAkunGames;
  List<RiwayatPembelianModel> listAkunGame = [];

  final int idPembeli = 2;

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
        return 'belum_bayar';
      case 1:
        return '';
      case 2:
        return 'sudah_bayar';
      default:
        return 'belum_bayar';
    }
  }

  Future<List<RiwayatPembelianModel>> fetchAkunGames(String status) async {
    final response = await http.get(
      Uri.parse('$apiEndPoint/transaksi/user/$idPembeli?status=$status'),
    );
    final responseBody = json.decode(response.body);

    try {
      if (response.statusCode == 200) {
        if (responseBody['success'] == false) {
          throw Exception('Failed to load akun games');
        }

        final data = responseBody['data'];
        return RiwayatPembelianModel.fromApiResponseList(data);
      } else {
        throw Exception('Failed to load akun games');
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
        drawer: const SidebarGamePembeli(),
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
              'Riyawat Pembelian',
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
                // unselectedLabelColor: const Color(0xFF131A2A),
                labelStyle: const TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: 18,
                  color: Color(0xFFFFFAFF),
                ),
                tabs: const [
                  Tab(text: 'Belum Dibayar'),
                  Tab(text: 'Diproses'),
                  Tab(text: 'Dibeli'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  buildAkunGameList(futureAkunGames, 'belum_bayar'),
                  buildAkunGameList(futureAkunGames, 'sudah_bayar'),
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
      Future<List<RiwayatPembelianModel>> futureAkunGames, String status) {
    return FutureBuilder<List<RiwayatPembelianModel>>(
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
              RiwayatPembelianModel pembelian = listAkunGame[index];

              return GestureDetector(
                onTap: () {
                  if (status == "belum_bayar") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailTransaksi(transaksiId: pembelian.id!),
                      ),
                    );
                  } else if (status == "proses_bayar") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailTransaksi(transaksiId: pembelian.id!),
                      ),
                    );
                  } else if (status == "sudah_bayar") {}
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  color: Colors.grey[800],
                  child: Text(
                    pembelian.invoice!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'BebasNeue',
                      fontSize: 18,
                      color: Color(0xFFFFFAFF),
                    ),
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
