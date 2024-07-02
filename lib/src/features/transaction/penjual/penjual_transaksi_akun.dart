import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/constants/api_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/features/transaction/model/riwayat_transaksi_model.dart';
import 'package:jbag/src/features/transaction/penjual/penjual_kirim_akun.dart';
import 'package:jbag/src/features/reuseable_component/penjual_sidebar.dart';
import 'package:jbag/src/features/account_games/penjual/dialog_penilaian.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PenjualTransaksiAkun extends StatefulWidget {
  const PenjualTransaksiAkun({super.key});

  @override
  State<PenjualTransaksiAkun> createState() => _PenjualTransaksiAkunState();
}

class _PenjualTransaksiAkunState extends State<PenjualTransaksiAkun>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _activeTabIndex = 0;
  late Future<List<RiwayatTransaksiModel>> futureAkunGames;
  List<RiwayatTransaksiModel> listAkunGame = [];

  int idPenjual = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    futureAkunGames = fetchAkunGames(getStatusFromIndex(_activeTabIndex));
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var penjual = jsonDecode(localStorage.getString('penjual')!);

    if (penjual != null) {
      setState(() {
        idPenjual = penjual['id'];
      });
    }
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _activeTabIndex = _tabController.index;
        if (idPenjual != 0) {
          futureAkunGames = fetchAkunGames(getStatusFromIndex(_activeTabIndex));
        }
      });
    }
  }

  String getStatusFromIndex(int index) {
    switch (index) {
      case 0:
        return 'pending';
      case 1:
        return 'terjual';
      default:
        return 'pending';
    }
  }

  Future<List<RiwayatTransaksiModel>> fetchAkunGames(String status) async {
    await _loadUserData();

    try {
      if (idPenjual == 0) {
        throw Exception('ID Penjual tidak ditemukan');
      }
      final response = await http.get(
        Uri.parse('$apiEndPoint/transaksi/penjual/$idPenjual?status=$status'),
      );
      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseBody['success'] == false) {
          throw Exception('Failed to load akun games');
        }

        final data = responseBody['data'];
        return RiwayatTransaksiModel.fromApiResponseList(data);
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
    return Scaffold(
      drawer: const PenjualSidebar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.dark,
      appBar: AppBar(
        backgroundColor: MyColors.dark,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.bars,
                color: MyColors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          "Transaksi",
          style: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: 42,
            color: MyColors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            color: MyColors.accent,
            child: TabBar(
              controller: _tabController,
              indicatorColor: MyColors.tertiary,
              labelColor: MyColors.dark,
              unselectedLabelColor: MyColors.dark,
              tabs: const [
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
                tabViewPending(futureAkunGames),
                tabViewTerjual(futureAkunGames),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tabViewPending(Future<List<RiwayatTransaksiModel>> futureAkunGames) {
    return FutureBuilder<List<RiwayatTransaksiModel>>(
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
              child: Text('Tidak Ada Transaksi',
                  style: TextStyle(color: MyColors.white)));
        } else {
          listAkunGame = snapshot.data!;

          return ListView.builder(
            itemCount: listAkunGame.length,
            itemBuilder: (context, index) {
              RiwayatTransaksiModel pembelian = listAkunGame[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PenjualKirimAkun(transaksiId: pembelian.id!),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  color: MyColors.accent,
                  child: Text(
                    pembelian.invoice!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'BebasNeue',
                      fontSize: 32,
                      color: MyColors.dark,
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

  Widget tabViewTerjual(Future<List<RiwayatTransaksiModel>> futureAkunGames) {
    return FutureBuilder<List<RiwayatTransaksiModel>>(
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
              child: Text('Tidak Ada Transaksi',
                  style: TextStyle(color: MyColors.white)));
        } else {
          listAkunGame = snapshot.data!;

          return ListView.builder(
            itemCount: listAkunGame.length,
            itemBuilder: (context, index) {
              RiwayatTransaksiModel pembelian = listAkunGame[index];

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: MyColors.accent,
                            child: Text(
                              pembelian.invoice!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'BebasNeue',
                                fontSize: 32,
                                color: MyColors.dark,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      color: MyColors.primary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Di Beli Tanggal',
                                style: TextStyle(
                                  fontFamily: 'LeagueGothic',
                                  fontSize: 32,
                                  color: MyColors.secondary,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                '14 Mei 2024',
                                style: TextStyle(
                                  fontFamily: 'LeagueGothic',
                                  fontSize: 32,
                                  color: MyColors.dark,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.accent,
                              foregroundColor: MyColors.dark,
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
                                fontFamily: 'BebasNeue',
                                fontSize: 32,
                                color: MyColors.dark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
