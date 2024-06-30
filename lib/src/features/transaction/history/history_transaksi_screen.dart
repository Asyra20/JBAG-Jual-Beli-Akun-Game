import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/reuseable_component/pembeli_sidebar.dart';
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
        return 'sudah_bayar';
      case 2:
        return 'terjual';
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
        ),
        body: Column(
          children: [
            const Text(
              'Riyawat Pembelian',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'BebasNeue',
                fontSize: 50,
                color: MyColors.white,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: MyColors.accent,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.red,
                labelColor: MyColors.dark,
                // unselectedLabelColor: MyColors.dark,
                labelStyle: const TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: 18,
                  color: MyColors.white,
                ),
                tabs: const [
                  Tab(text: 'Belum Dibayar'),
                  Tab(text: 'Diproses'),
                  Tab(text: 'Dibeli'),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    tabView(futureAkunGames),
                    tabView(futureAkunGames),
                    tabViewTerjual(futureAkunGames),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabView(Future<List<RiwayatPembelianModel>> futureAkunGames) {
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
              child: Text('Tidak Ada Transaksi',
                  style: TextStyle(color: MyColors.white)));
        } else {
          listAkunGame = snapshot.data!;

          return ListView.builder(
            itemCount: listAkunGame.length,
            itemBuilder: (context, index) {
              RiwayatPembelianModel pembelian = listAkunGame[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailTransaksi(transaksiId: pembelian.id!),
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

  Widget tabViewTerjual(Future<List<RiwayatPembelianModel>> futureAkunGames) {
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
              child: Text('Tidak Ada Transaksi',
                  style: TextStyle(color: MyColors.white)));
        } else {
          listAkunGame = snapshot.data!;

          return ListView.builder(
            itemCount: listAkunGame.length,
            itemBuilder: (context, index) {
              RiwayatPembelianModel pembelian = listAkunGame[index];

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
                              'NILAI',
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

class DialogPenilaian extends StatelessWidget {
  const DialogPenilaian({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MyColors.primary,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'PENILAIAN',
              style: TextStyle(
                  color: MyColors.dark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LeagueGothic'),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rating',
                style:
                    TextStyle(color: MyColors.dark, fontFamily: 'LeagueGothic'),
              ),
              Row(
                children: List.generate(5, (index) {
                  return const Icon(
                    Icons.star,
                    color: MyColors.accent,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Review',
            style: TextStyle(color: MyColors.dark, fontFamily: 'LeagueGothic'),
          ),
          const SizedBox(height: 5),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              filled: true,
              fillColor: MyColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.accent,
                foregroundColor: MyColors.dark,
              ),
              onPressed: () {
                // Handle the submit action
                Navigator.of(context).pop();
              },
              child: const Text(
                'KIRIM',
                style: TextStyle(fontFamily: 'LeagueGothic'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
