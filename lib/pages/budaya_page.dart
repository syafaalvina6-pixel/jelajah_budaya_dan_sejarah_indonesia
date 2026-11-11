import 'package:flutter/material.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/models/budaya_model.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/pages/detail_budaya_page.dart';

class BudayaPage extends StatefulWidget {
  const BudayaPage({super.key});

  @override
  State<BudayaPage> createState() => _BudayaPageState();
}

class _BudayaPageState extends State<BudayaPage> {
  List<String> savedNames = [];

  @override
  void initState() {
    super.initState();
    _loadSavedStatus();
  }

  Future<void> _loadSavedStatus() async {
    List<String> list = await KoleksiManager.getSavedBudayaNames();
    if (mounted) {
      setState(() {
        savedNames = list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A49E3),
        title: const Text('Daftar Budaya', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listBudayaData.length,
        itemBuilder: (context, index) {
          final item = listBudayaData[index];
          bool isSaved = savedNames.contains(item.nama);

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item.imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.purple.shade100,
                    child: const Icon(Icons.collections, color: Color(0xFF5A49E3)),
                  ),
                ),
              ),
              title: Text(item.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${item.daerah} (${item.wilayah})'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: isSaved ? const Color(0xFF5A49E3) : Colors.grey,
                    ),
                    onPressed: () async {
                      await KoleksiManager.toggleBookmark(item.nama);
                      _loadSavedStatus();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isSaved
                                ? '${item.nama} dihapus dari Koleksi Saya'
                                : '${item.nama} disimpan ke Koleksi Saya'),
                            duration: const Duration(milliseconds: 900),
                            backgroundColor: const Color(0xFF5A49E3),
                          ),
                        );
                      }
                    },
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailBudayaPage(
                      budaya: item,
                    ),
                  ),
                );
                _loadSavedStatus();
              },
            ),
          );
        },
      ),
    );
  }
}