import 'package:flutter/material.dart';

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
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'LeagueGothic'),
              ),
              SizedBox(height: 10),
              Text(
                'Penjual',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'LeagueGothic'),
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
                child: TextField(
                  controller: _descriptionController,
                  onChanged: (value) {
                    // Implementasi yang sesuai saat teks berubah
                  },
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'LeagueGothic'),
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
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'LeagueGothic'),
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
                      backgroundColor: const Color(0xFFFFC639),
                      foregroundColor: const Color(0xFF131A2A),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 5),
                        const Text(
                          'Edit',
                          style: TextStyle(fontFamily: 'LeagueGothic'),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Implement your delete functionality here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 5),
                        const Text(
                          'Hapus',
                          style: TextStyle(fontFamily: 'LeagueGothic'),
                        ),
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
