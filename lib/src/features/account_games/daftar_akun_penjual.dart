import 'package:flutter/material.dart';
import 'package:jbag/src/features/auth/login_screen.dart';
import 'package:jbag/src/features/profile/pembeli/profil_pembeli_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    ProfilPembeli(),
    DaftarAkunScreen(),
    Text(
      'Index 2: Tambah Akun',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF131A2A),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF131A2A),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              Container(
                color: const Color(0xFF131A2A),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                selected: _selectedIndex == 0,
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'Daftar Akun',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                selected: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'Tambah Akun',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                selected: _selectedIndex == 2,
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                },
              ),
              Spacer(),
              ListTile(
                title: const Text(
                  'Report',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color(0xFFECE8E1),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "PEMBERITAHUAN",
                              style: TextStyle(
                                fontFamily: 'BebasNeue',
                                fontSize: 24,
                                color: Color(0xFF131A2A),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'APAKAH ANDA INGIN LOGOUT!?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'BebasNeue',
                                fontSize: 18,
                                color: Color(0xFF131A2A),
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFFC639),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    );
                                  },
                                  child: Text(
                                    "YES SIR!",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'BebasNeue',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFF9564F),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "NAH!",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'BebasNeue',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DaftarAkunScreen extends StatelessWidget {
  const DaftarAkunScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF131A2A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF131A2A),
          elevation: 0,
          title: Text(
            'Daftar Akun',
            style: TextStyle(
              fontFamily: 'BebasNeue',
              fontSize: 48,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Container(
              color: const Color(0xFFFFC639),
              child: TabBar(
                indicatorColor: Colors.red,
                labelColor: const Color(0xFF131A2A),
                unselectedLabelColor: const Color(0xFF131A2A),
                tabs: [
                  Tab(text: 'Dijual'),
                  Tab(text: 'Pending'),
                  Tab(text: 'Terjual'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
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
                price: price, description: description, akunName: description),
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
                        fontFamily: 'BebasNeue'),
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(color: Colors.white, fontSize: 16),
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
              detail: 'Email Akun ML via Moonton:\nDzakyGG@gmail.com\n\nPassword Akun:\nDzakyTampan123\n\nTerima Kasih telah membeli di toko kami, jangan lupa bintang 5 :D',
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
                        fontFamily: 'BebasNeue'),
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(color: Colors.white, fontSize: 16),
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
                      fontFamily: 'BebasNeue'),
                ),
              ),
              Text(
                price,
                style: TextStyle(color: Colors.white, fontSize: 16),
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
                    color: Colors.white, fontSize: 14, fontFamily: 'BebasNeue'),
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
                        fontFamily: 'BebasNeue'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: const Color(0xFFFFC639),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
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
                                        fontSize: 32,
                                        fontFamily: 'BebasNeue',
                                        fontWeight: FontWeight.bold),
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
                                          fontSize: 24,
                                          fontFamily: 'BebasNeue'),
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
                                      fontSize: 24,
                                      fontFamily: 'BebasNeue'),
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
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      backgroundColor: const Color(0xFFFFC639),
                                      foregroundColor: Colors.black,
                                    ),
                                    onPressed: () {
                                      // Handle the submit action
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'KEMBALI',
                                      style: TextStyle(
                                          fontFamily: 'BebasNeue',
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      'LIHAT NILAI',
                      style: TextStyle(fontFamily: 'BebasNeue', fontSize: 24),
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

class AkunDetailScreen extends StatefulWidget {
  final String price;
  final String description;
  final String akunName;

  AkunDetailScreen({
    Key? key,
    required this.price,
    required this.description,
    required this.akunName,
  }) : super(key: key);

  @override
  _AkunDetailScreenState createState() => _AkunDetailScreenState();
}

class _AkunDetailScreenState extends State<AkunDetailScreen> {
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

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
                widget.akunName,
                style: TextStyle(
                    color: Colors.white, fontSize: 32, fontFamily: 'BebasNeue'),
              ),
              SizedBox(height: 10),
              Text(
                'Penjual',
                style: TextStyle(
                    color: Colors.grey, fontSize: 20, fontFamily: 'BebasNeue'),
              ),
              SizedBox(height: 10),
              Container(
                height: 160,
                width: double.infinity,
                color: Colors.grey[800],
                child: Center(
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQSfrZ5oLUBB1CkW-IAxwa8oQJECoYK-JMNk-US5AgsG9ZXMM4',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Deskripsi Akun',
                style: TextStyle(
                    color: Colors.grey, fontSize: 20, fontFamily: 'BebasNeue'),
              ),
              SizedBox(height: 10),
              Container(
                height: 320,
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                color: Colors.grey[800],
                child: TextField(
                  controller: _descriptionController,
                  onChanged: (value) {
                    // Implementasi yang sesuai saat teks berubah
                  },
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Masukkan deskripsi',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[800],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                widget.price,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Implement your edit functionality here
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: const Color(0xFFFFC639),
                      foregroundColor: const Color(0xFF131A2A),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 5),
                        Text(
                          'Edit',
                          style: TextStyle(fontFamily: 'BebasNeue'),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Implement your delete functionality here
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 5),
                        Text('Hapus',
                            style: TextStyle(fontFamily: 'BebasNeue')),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
                    color: Colors.white, fontSize: 32, fontFamily: 'BebasNeue'),
              ),
              SizedBox(height: 10),
              Text(
                'Email Pembeli',
                style: TextStyle(
                    color: Colors.grey, fontSize: 20, fontFamily: 'BebasNeue'),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                color: const Color(0xFFFFC639),
                child: Text(
                  email,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'BebasNeue'),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Detail Akun',
                style: TextStyle(
                    color: Colors.grey, fontSize: 20, fontFamily: 'BebasNeue'),
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
                      fontSize: 20,
                      fontFamily: 'BebasNeue'),
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
                                  fontFamily: 'BebasNeue'),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'AKUN TELAH TERJUAL',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'BebasNeue'),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFC639),
                                foregroundColor: Colors.black,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: Text(
                                'KEMBALI',
                                style: TextStyle(
                                    fontFamily: 'BebasNeue', fontSize: 20),
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
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text('KIRIM',
                    style: TextStyle(fontFamily: 'BebasNeue', fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
