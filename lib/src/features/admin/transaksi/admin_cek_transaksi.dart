import 'package:flutter/material.dart';
import 'package:jbag/src/features/admin/transaksi/admin_detail_transaksi.dart';

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
                color: const Color(0xFFFFC639),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'NOMOR INVOICE',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontFamily: 'BebasNeue',
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