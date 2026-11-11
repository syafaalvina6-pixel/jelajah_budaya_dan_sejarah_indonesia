import 'package:flutter/material.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/models/budaya_model.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/pages/detail_budaya_page.dart';

class KoleksiPage extends StatefulWidget {
  const KoleksiPage({super.key});

  @override
  State<KoleksiPage> createState() => _KoleksiPageState();
}

class _KoleksiPageState extends State<KoleksiPage> {
  String selectedFilter = 'Semua';
  List<Budaya> savedBudayaList = [];

  @override
  void initState() {
    super.initState();
    _loadSavedItems();
  }

  Future<void> _loadSavedItems() async {
    List<String> savedNames = await KoleksiManager.getSavedBudayaNames();
    List<Budaya> filtered = listBudayaData.where((b) => savedNames.contains(b.nama)).toList();

    if (mounted) {
      setState(() {
        savedBudayaList = filtered;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Budaya> displayList = selectedFilter == 'Semua'
        ? savedBudayaList
        : savedBudayaList.where((b) => b.wilayah == selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A49E3),
        title: const Text('Koleksi Saya', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: ['Semua', 'Jawa', 'Sumatera', 'Bali', 'Kalimantan'].map((filter) {
                bool isSelected = selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    selectedColor: const Color(0xFF5A49E3),
                    backgroundColor: const Color(0xFFECE6F8),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF5A49E3),
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (val) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: displayList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bookmark_border, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        const Text(
                          'Belum ada budaya tersimpan.\nTekan ikon penanda (bookmark) di Daftar Budaya untuk menyimpan!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      final item = displayList[index];
                      return GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailBudayaPage(
                                budaya: item,
                              ),
                            ),
                          );
                          _loadSavedItems();
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                  child: Image.asset(
                                    item.imagePath,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: Colors.purple.shade100,
                                      child: const Icon(Icons.landscape, color: Color(0xFF5A49E3)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                    Text(item.daerah, style: const TextStyle(color: Colors.black54, fontSize: 11)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}