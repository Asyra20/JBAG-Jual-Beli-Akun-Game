import 'package:flutter/material.dart';

class DialogPenilaian extends StatelessWidget {
  const DialogPenilaian({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: const Color(0xFFECE8E1),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'PENILAIAN',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontFamily: 'BebasNeue',
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rating',
                style: TextStyle(
                    color: Colors.black, fontSize: 24, fontFamily: 'BebasNeue'),
              ),
              Row(
                children: List.generate(5, (index) {
                  return const Icon(
                    Icons.star,
                    color: Color(0xFFFFC639),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Review',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontFamily: 'BebasNeue'),
          ),
          const SizedBox(height: 5),
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
          const SizedBox(height: 10),
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
              child: const Text(
                'KEMBALI',
                style: TextStyle(fontFamily: 'BebasNeue', fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
