import 'package:flutter/material.dart';

class PendingDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String email;
  final String detail;

  const PendingDetailScreen({
    Key? key,
    required this.imageUrl,
    required this.email,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF131A2A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFF131A2A),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: const Color(0xFF131A2A),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Akun Pending',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'LeagueGothic'),
              ),
              SizedBox(height: 10),
              Text(
                'Email Pembeli',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'LeagueGothic'),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                color: Colors.grey[800],
                child: Text(
                  email,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'LeagueGothic'),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Detail Akun',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'LeagueGothic'),
              ),
              SizedBox(height: 10),
              Container(
                height: 320,
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                color: Colors.grey[800],
                child: Text(
                  detail,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'LeagueGothic'),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color(0xFFECE8E1),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'PEMBERITAHUAN',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'LeagueGothic'),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'AKUN TELAH TERJUAL',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'LeagueGothic'),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFC639),
                                foregroundColor: Colors.black,
                              ),
                              child: const Text(
                                'KEMBALI',
                                style: TextStyle(fontFamily: 'LeagueGothic'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC639),
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  'KIRIM',
                  style: TextStyle(fontFamily: 'LeagueGothic'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
