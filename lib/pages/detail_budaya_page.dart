import 'package:flutter/material.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/models/budaya_model.dart';

class DetailBudayaPage extends StatelessWidget {
  final Budaya budaya;

  const DetailBudayaPage({super.key, required this.budaya});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A49E3),
        title: const Text('Detail Budaya', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                budaya.gambar,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.purple.shade200,
                  child: const Icon(Icons.image, size: 80, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              budaya.nama,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.purple),
                const SizedBox(width: 4),
                Text(budaya.asal, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text(budaya.kategori)),
                const Chip(label: Text('Sejarah')),
              ],
            ),
            const SizedBox(height: 12),
            Text(budaya.deskripsi, style: const TextStyle(height: 1.5)),
            const SizedBox(height: 20),
            const Text('Ciri Khas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...budaya.ciriKhas.map((ciri) => Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 8, color: Color(0xFF5A49E3)),
                      const SizedBox(width: 8),
                      Expanded(child: Text(ciri)),
                    ],
                  ),
                )),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A49E3),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Kembali', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}