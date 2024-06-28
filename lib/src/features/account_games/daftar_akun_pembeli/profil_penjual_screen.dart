import 'package:flutter/material.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/account_games/daftar_akun_pembeli/kartu_akun_game.dart';

class ProfilPenjualScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF131A2A)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'NopStore',
                style: TextStyle(
                  fontFamily: 'LeagueGothic',
                  fontSize: 50,
                  color: Color(0xFF131A2A),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '5.0',
                    style: TextStyle(
                      fontFamily: 'LeagueGothic',
                      fontSize: 35,
                      color: Color(0xFF131A2A),
                    ),
                  ),
                  SizedBox(width: 4),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 40,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '(10)',
                    style: TextStyle(
                      fontFamily: 'LeagueGothic',
                      fontSize: 28,
                      color: Color(0xFF131A2A),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {},
                child: Text(
                  '0812345',
                  style: TextStyle(
                    fontFamily: 'LeagueGothic',
                    fontSize: 30,
                    color: Color(0xFF131A2A),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                color: Color(0xFF131A2A),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Daftar Akun',
                        style: TextStyle(
                          fontFamily: 'LeagueGothic',
                          fontSize: 30,
                          color: Color(0xFFFFFAFF),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: MyColors.dark,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFC639)),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      dropdownColor: MyColors.dark,
                      value: 'Mobile Legends',
                      items: [
                        DropdownMenuItem(
                          child: Text('Mobile Legends',
                              style: TextStyle(color: MyColors.white)),
                          value: 'Mobile Legends',
                        ),
                        DropdownMenuItem(
                          child: Text('Free Fire',
                              style: TextStyle(color: MyColors.white)),
                          value: 'Free Fire',
                        ),
                      ],
                      onChanged: (value) {},
                      iconEnabledColor: MyColors.white,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: MyColors.dark,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFC639)),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search, color: MyColors.white),
                          onPressed: () {},
                        ),
                      ),
                      style: TextStyle(color: MyColors.white),
                      cursorColor: MyColors.white,
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          KartuAkunGame(
                            imageUrl:
                                'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSpSxJS6iDjzpWTViuc1VovCyBT8tCz7Q7FBhGDhP5O-FMXMcK5',
                            title: 'AKUN RAWAT PRIBADI SULTAN',
                            price: 'Rp 5.000.000',
                            logoUrl:
                                'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhoUjcDjDw_TMXthjcyBqcDzmvVEOFc1KZ3Zwuum3Bawyot5g8bXdILcAMF2Eb8MLYAJr1vscCS-fec8sIyqj_1tMTJ5KZjPwodKhXyqaEBcCNKwoUcpPNpM5wL68NXOHFto8cHaW3lrFBc/s2048/mlbb+old-01.png',
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => DetailAkunScreen(
                              //       imageUrl:
                              //           'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSpSxJS6iDjzpWTViuc1VovCyBT8tCz7Q7FBhGDhP5O-FMXMcK5',
                              //       title: 'AKUN RAWAT PRIBADI SULTAN',
                              //       price: 'Rp 5.000.000',
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                          SizedBox(height: 16),
                          KartuAkunGame(
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQSfrZ5oLUBB1CkW-IAxwa8oQJECoYK-JMNk-US5AgsG9ZXMM4',
                            title: 'AKUN PRO PLAYER SULTAN',
                            price: 'Rp 2.000.000',
                            logoUrl:
                                'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhoUjcDjDw_TMXthjcyBqcDzmvVEOFc1KZ3Zwuum3Bawyot5g8bXdILcAMF2Eb8MLYAJr1vscCS-fec8sIyqj_1tMTJ5KZjPwodKhXyqaEBcCNKwoUcpPNpM5wL68NXOHFto8cHaW3lrFBc/s2048/mlbb+old-01.png',
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => DetailAkunScreen(
                              //       imageUrl:
                              //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQSfrZ5oLUBB1CkW-IAxwa8oQJECoYK-JMNk-US5AgsG9ZXMM4',
                              //       title: 'AKUN PRO PLAYER SULTAN',
                              //       price: 'Rp 2.000.000',
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                          SizedBox(height: 16),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'LIHAT LEBIH BANYAK',
                              style: TextStyle(
                                fontFamily: 'LeagueGothic',
                                fontSize: 20,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFF5F5F5),
    );
  }
}
