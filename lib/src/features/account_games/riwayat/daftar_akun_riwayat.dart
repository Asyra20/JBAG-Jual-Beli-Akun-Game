import 'package:flutter/material.dart';
import 'package:jbag/src/features/account_games/riwayat/akun_detail_riwayat.dart';
import 'package:jbag/src/features/account_games/riwayat/pending_detail_riwayat.dart';

class DaftarAkunScreen extends StatelessWidget {
  const DaftarAkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF131A2A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF131A2A),
          elevation: 0,
          title: const Text(
            'Pembelian Saya',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontFamily: 'LeagueGothic'),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              color: const Color(0xFFFFC639),
              child: const TabBar(
                indicatorColor: Colors.red,
                labelColor: Color(0xFF131A2A),
                unselectedLabelColor: Color(0xFF131A2A),
                labelStyle: TextStyle(fontFamily: 'LeagueGothic'),
                tabs: [
                  Tab(text: 'Belum Dibayar'),
                  Tab(text: 'Diproses'),
                  Tab(text: 'Dibeli'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      _buildAkunItem(
                          context,
                          'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSpSxJS6iDjzpWTViuc1VovCyBT8tCz7Q7FBhGDhP5O-FMXMcK5',
                          'Rp 5.000.000',
                          'AKUN RAWAT PRIBADI SULTAN'),
                      _buildAkunItem(
                          context,
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQSfrZ5oLUBB1CkW-IAxwa8oQJECoYK-JMNk-US5AgsG9ZXMM4',
                          'Rp 2.000.000',
                          'AKUN PRO PLAYER SULTAN'),
                    ],
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      _buildPendingAkunItem(
                          context,
                          'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSpSxJS6iDjzpWTViuc1VovCyBT8tCz7Q7FBhGDhP5O-FMXMcK5',
                          'Rp 5.000.000',
                          'PENDING - AKUN RAWAT PRIBADI SULTAN'),
                      _buildPendingAkunItem(
                          context,
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQSfrZ5oLUBB1CkW-IAxwa8oQJECoYK-JMNk-US5AgsG9ZXMM4',
                          'Rp 2.000.000',
                          'PENDING - AKUN PRO PLAYER SULTAN'),
                    ],
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      _buildTerjualAkunItem(
                          context,
                          'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSpSxJS6iDjzpWTViuc1VovCyBT8tCz7Q7FBhGDhP5O-FMXMcK5',
                          'Rp 5.000.000',
                          'AKUN RAWAT PRIBADI SULTAN',
                          '14 Mei 2024'),
                      _buildTerjualAkunItem(
                          context,
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQSfrZ5oLUBB1CkW-IAxwa8oQJECoYK-JMNk-US5AgsG9ZXMM4',
                          'Rp 2.000.000',
                          'AKUN PRO PLAYER SULTAN',
                          '10 Juni 2024'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAkunItem(
      BuildContext context, String imageUrl, String price, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AkunDetailScreen(
                price: price,
                description: description,
                akunName:
                    description), // Menggunakan description sebagai nama akun
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        color: Colors.grey[800],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(
                        color: const Color(0xFFFFC639),
                        fontSize: 18,
                        fontFamily: 'LeagueGothic'),
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'LeagueGothic'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingAkunItem(
      BuildContext context, String imageUrl, String price, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PendingDetailScreen(
              imageUrl: imageUrl,
              email: 'NopalGaming@gmail.com',
              detail:
                  'Email Akun ML via Moonton:\nDzakyGG@gmail.com\n\nPassword Akun:\nDzakyTampan123\n\nTerima Kasih telah membeli di toko kami, jangan lupa bintang 5 :D',
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        color: Colors.grey[800],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(
                        color: const Color(0xFFFFC639),
                        fontSize: 18,
                        fontFamily: 'LeagueGothic'),
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'LeagueGothic'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTerjualAkunItem(BuildContext context, String imageUrl,
      String price, String description, String soldDate) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.all(10),
      color: Colors.grey[800],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  description,
                  style: TextStyle(
                      color: const Color(0xFFFFC639),
                      fontSize: 18,
                      fontFamily: 'LeagueGothic'),
                ),
              ),
              Text(
                price,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'LeagueGothic'),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terjual tanggal',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'LeagueGothic'),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    soldDate,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'LeagueGothic'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC639),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: const Color(0xFFECE8E1),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'PENILAIAN',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'LeagueGothic'),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Rating',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'LeagueGothic'),
                                    ),
                                    // Replace with your own rating widget
                                    Row(
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          Icons.star,
                                          color: const Color(0xFFFFC639),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Review',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'LeagueGothic'),
                                ),
                                SizedBox(height: 5),
                                TextField(
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFFC639),
                                      foregroundColor: Colors.black,
                                    ),
                                    onPressed: () {
                                      // Handle the submit action
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'KIRIM',
                                      style:
                                          TextStyle(fontFamily: 'LeagueGothic'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      'NILAI',
                      style: TextStyle(fontFamily: 'LeagueGothic'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
