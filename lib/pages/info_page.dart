import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A49E3),
        title: const Text('Tentang Aplikasi', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Jelajah Nusantara',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF3B2B9A)),
            ),
            SizedBox(height: 8),
            Text(
              'Aplikasi edukasi budaya dan sejarah Indonesia dalam bentuk permainan interaktif.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            SizedBox(height: 32),
            ListTile(
              leading: Icon(Icons.info_outline, color: Color(0xFF5A49E3)),
              title: Text('Versi'),
              subtitle: Text('1.0.0'),
            ),
            ListTile(
              leading: Icon(Icons.person_outline, color: Color(0xFF5A49E3)),
              title: Text('Pengembang'),
              subtitle: Text('Syafa Alvina Aprilia Putri'),
            ),
            ListTile(
              leading: Icon(Icons.email_outlined, color: Color(0xFF5A49E3)),
              title: Text('Kontak'),
              subtitle: Text('syafaalvina2@gmail.com'),
            ),
          ],
        ),
      ),
    );
  }
}