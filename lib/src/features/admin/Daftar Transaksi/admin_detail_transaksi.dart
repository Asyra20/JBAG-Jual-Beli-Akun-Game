import 'package:flutter/material.dart';

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
                color: const Color(0xFFFFC639),
                child: ListTile(
                  title: Text(
                    'DETAIL AKUN',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'BebasNeue',
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Colors.black),
                  onTap: () {
                    // detail akun
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
                color: const Color(0xFFFFC639),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'HUBUNGI PENJUAL',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'BebasNeue',
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