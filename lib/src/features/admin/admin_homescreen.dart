import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminMenuScreen(),
    );
  }
}

class AdminMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131A2A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              Center(
                child: Text(
                  'ADMIN',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    color: Color(0xFFFFFAFF),
                    fontSize: 48,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReviewAkunPenjualScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: Text(
                          'REVIEW AKUN PENJUAL',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CekTransaksiScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: Text(
                          'CEK TRANSAKSI',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text(
                      'LOGOUT',
                      style: TextStyle(
                        color: Color(0xFFFFFAFF),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewAkunPenjualScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF131A2A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'REVIEW AKUN PENJUAL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    color: Color(0xFFFFFAFF),
                    fontSize: 48,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                color: Colors.yellow,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'NAMA PENJUAL',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.info, color: Colors.black),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NamaPenjualScreen()),
                    );
                  },
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NamaPenjualScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF131A2A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'REVIEW AKUN PENJUAL',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    color: Color(0xFFFFFAFF),
                    fontSize: 48,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildTextField('Nama'),
                    _buildTextField('Username'),
                    _buildTextField('Email'),
                    _buildTextField('Password'),
                    _buildTextField('Nomor Telepon'),
                    _buildTextField('Foto KTP + Muka', isPhotoField: true),
                    _buildTextField('Jenis E-wallet'),
                    _buildTextField('Nama Profil pada e-wallet'),
                    _buildTextField('Nomer e-wallet'),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                          child: Text(
                            'REJECT',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                          child: Text(
                            'ACCEPT',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {bool isPhotoField = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          fillColor: Color(0xFFFFFAFF),
          filled: true,
          suffixIcon:
              isPhotoField ? Icon(Icons.camera_alt, color: Colors.black) : null,
        ),
      ),
    );
  }
}

class CekTransaksiScreen extends StatelessWidget {
  const CekTransaksiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF131A2A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'CEK TRANSAKSI',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    color: Color(0xFFFFFAFF),
                    fontSize: 48,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                color: Colors.yellow,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'NOMOR INVOICE',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.info, color: Colors.black),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailTransaksiScreen()),
                    );
                  },
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailTransaksiScreen extends StatelessWidget {
  const DetailTransaksiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF131A2A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'DETAIL TRANSAKSI',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    color: Color(0xFFFFFAFF),
                    fontSize: 48,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                color: Colors.yellow,
                child: ListTile(
                  title: Text(
                    'DETAIL AKUN',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Colors.black),
                  onTap: () {
                    
                  },
                ),
              ),
              SizedBox(height: 30),
              _buildDetailItem('NOMOR INVOICE'),
              SizedBox(height: 5),
              _buildDetailItem('TANGGAL TRANSAKSI'),
              SizedBox(height: 5),
              _buildDetailItem('NOMOR E-WALLET'),
              SizedBox(height: 5),
              _buildDetailItem('HARGA TOTAL'),
              SizedBox(height: 5),
              _buildDetailItem('BUKTI PEMBAYARAN'),
              Spacer(),
              Container(
                width: double.infinity,
                color: Colors.yellow,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'HUBUNGI PENJUAL',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label) {
    return Container(
      width: double.infinity,
      color: Colors.grey[800],
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Text(
        label,
        style: TextStyle(
          color: Color(0xFFFFFAFF),
          fontSize: 18,
        ),
      ),
    );
  }
}