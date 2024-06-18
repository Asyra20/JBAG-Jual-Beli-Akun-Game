import 'package:flutter/material.dart';
import 'package:jbag/src/constants/colors.dart';

class DaftarAkunGamesLayar extends StatelessWidget {
  const DaftarAkunGamesLayar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white), // Mengubah warna ikon garis tiga menjadi putih
        title: Text(
          'Daftar Akun Games',
          style: TextStyle(color: Colors.white), // Mengubah warna teks menjadi putih
        ),
        backgroundColor: Colors.blueGrey[900], // Mengubah latar belakang menjadi biru gelap
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blueGrey[900], // Mengubah latar belakang sidebar menjadi biru gelap
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle, color: Colors.white),
                title: Text(
                  'Profil',
                  style: TextStyle(color: Colors.white), // Mengubah warna teks menjadi putih
                ),
                onTap: () {
                  // Handle the tap
                },
              ),
              ListTile(
                leading: Icon(Icons.games, color: Colors.white),
                title: Text(
                  'Daftar Akun Games',
                  style: TextStyle(color: Colors.white), // Mengubah warna teks menjadi putih
                ),
                onTap: () {
                  // Handle the tap
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart, color: Colors.white),
                title: Text(
                  'Keranjang',
                  style: TextStyle(color: Colors.white), // Mengubah warna teks menjadi putih
                ),
                onTap: () {
                  // Handle the tap
                },
              ),
              ListTile(
                leading: Icon(Icons.history, color: Colors.white),
                title: Text(
                  'Riwayat',
                  style: TextStyle(color: Colors.white), // Mengubah warna teks menjadi putih
                ),
                onTap: () {
                  // Handle the tap
                },
              ),
              Divider(color: Colors.white), // Menambahkan garis pemisah
              ListTile(
                title: Text(
                  'Report',
                  style: TextStyle(color: Colors.white), // Mengubah warna teks menjadi putih
                ),
                onTap: () {
                  // Handle the tap
                },
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white), // Mengubah warna teks menjadi putih
                ),
                onTap: () {
                  // Handle the tap
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey[900], // Mengubah latar belakang menjadi biru gelap
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                dropdownColor: Colors.blueGrey[900],
                value: 'Mobile Legends',
                items: [
                  DropdownMenuItem(child: Text('Mobile Legends', style: TextStyle(color: Colors.white)), value: 'Mobile Legends'),
                  DropdownMenuItem(child: Text('Free Fire', style: TextStyle(color: Colors.white)), value: 'Free Fire'),
                ],
                onChanged: (value) {},
                iconEnabledColor: MyColors.accent, // Mengubah ikon menjadi kuning
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey[900], // Mengubah latar belakang menjadi biru gelap
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.white), // Mengubah ikon menjadi kuning
                    onPressed: () {},
                  ),
                ),
                style: TextStyle(color: Colors.white), // Mengubah warna teks menjadi putih
              ),
              SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    KartuAkunGame(
                      imageUrl: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSpSxJS6iDjzpWTViuc1VovCyBT8tCz7Q7FBhGDhP5O-FMXMcK5',
                      title: 'AKUN RAWAT PRIBADI SULTAN',
                      price: 'Rp 5.000.000',
                      logoUrl: 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhoUjcDjDw_TMXthjcyBqcDzmvVEOFc1KZ3Zwuum3Bawyot5g8bXdILcAMF2Eb8MLYAJr1vscCS-fec8sIyqj_1tMTJ5KZjPwodKhXyqaEBcCNKwoUcpPNpM5wL68NXOHFto8cHaW3lrFBc/s2048/mlbb+old-01.png',
                    ),
                    SizedBox(height: 16),
                    KartuAkunGame(
                      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQSfrZ5oLUBB1CkW-IAxwa8oQJECoYK-JMNk-US5AgsG9ZXMM4',
                      title: 'AKUN PRO PLAYER SULTAN',
                      price: 'Rp 2.000.000',
                      logoUrl: 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhoUjcDjDw_TMXthjcyBqcDzmvVEOFc1KZ3Zwuum3Bawyot5g8bXdILcAMF2Eb8MLYAJr1vscCS-fec8sIyqj_1tMTJ5KZjPwodKhXyqaEBcCNKwoUcpPNpM5wL68NXOHFto8cHaW3lrFBc/s2048/mlbb+old-01.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[900], // Mengubah latar belakang menjadi biru gelap
    );
  }
}

class KartuAkunGame extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String logoUrl;

  KartuAkunGame({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,  // Memberikan lebar penuh ke container
      color: Colors.yellow[500], // Mengubah latar belakang menjadi biru gelap
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                imageUrl,
                width: double.infinity,  // Memastikan gambar mengambil lebar penuh
                fit: BoxFit.cover,  // Menjaga proporsi gambar
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  color: Colors.black54,
                  child: Text(
                    price,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.network(
                  logoUrl,
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black, // Mengubah warna teks menjadi kuning
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
