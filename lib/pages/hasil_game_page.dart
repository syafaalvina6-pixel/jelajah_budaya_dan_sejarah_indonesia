import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/pages/tantangan_page.dart';

class LevelHasilData {
  final String namaBudaya;
  final String daerah;
  final String imagePath;
  final String deskripsi;

  const LevelHasilData({
    required this.namaBudaya,
    required this.daerah,
    required this.imagePath,
    required this.deskripsi,
  });
}

class HasilGamePage extends StatelessWidget {
  final String wilayah;
  final int currentLevel;

  const HasilGamePage({
    super.key,
    this.wilayah = 'Jawa',
    required this.currentLevel,
  });

  static const Map<String, Map<int, LevelHasilData>> hasilMapData = {
    'Jawa': {
      1: LevelHasilData(namaBudaya: 'Batik', daerah: 'Jawa Tengah', imagePath: 'assets/images/batik.jpg', deskripsi: 'Batik adalah kain bergambar khas Indonesia yang dibuat dengan teknik rintang lilin (malam).'),
      2: LevelHasilData(namaBudaya: 'Wayang Kulit', daerah: 'Jawa Tengah / DIY', imagePath: 'assets/images/wayang.jpg', deskripsi: 'Seni pertunjukan bayangan tradisional menggunakan pahatan kulit lembu/kerbau.'),
      3: LevelHasilData(namaBudaya: 'Keris', daerah: 'Jawa Tengah', imagePath: 'assets/images/keris.jpg', deskripsi: 'Senjata tikam golongan belati dengan bilah berlekuk khas kebudayaan Nusantara.'),
      4: LevelHasilData(namaBudaya: 'Reog Ponorogo', daerah: 'Jawa Timur', imagePath: 'assets/images/reog.jpg', deskripsi: 'Tarian tradisional Jawa Timur yang menampilkan dadak merak berukuran besar.'),
      5: LevelHasilData(namaBudaya: 'Gamelan', daerah: 'Jawa / Bali', imagePath: 'assets/images/gamelan.jpg', deskripsi: 'Ansambel musik tradisional yang didominasi instrumen musik pukul perunggu.'),
    },
    'Sumatera': {
      1: LevelHasilData(namaBudaya: 'Rumah Gadang', daerah: 'Sumatera Barat', imagePath: 'assets/images/rumah gadang.jpg', deskripsi: 'Rumah adat Minangkabau dengan atap bergonjong menyerupai tanduk kerbau.'),
      2: LevelHasilData(namaBudaya: 'Kain Ulos', daerah: 'Sumatera Utara', imagePath: 'assets/images/ulos.jpg', deskripsi: 'Kain tenun khas suku Batak yang digunakan dalam berbagai upacara adat.'),
      3: LevelHasilData(namaBudaya: 'Jam Gadang', daerah: 'Sumatera Barat', imagePath: 'assets/images/jam gadang.jpg', deskripsi: 'Menara jam ikonik yang terletak di pusat kota Bukittinggi.'),
      4: LevelHasilData(namaBudaya: 'Danau Toba', daerah: 'Sumatera Utara', imagePath: 'assets/images/danau toba.jpg', deskripsi: 'Danau vulkanik terbesar di dunia dengan Pulau Samosir di tengahnya.'),
      5: LevelHasilData(namaBudaya: 'Candi Muara Takus', daerah: 'Riau', imagePath: 'assets/images/candi muara takus.jpg', deskripsi: 'Situs candi Buddha tertua di Sumatera peninggalan kerajaan Sriwijaya.'),
    },
    'Bali': {
      1: LevelHasilData(namaBudaya: 'Tari Kecak', daerah: 'Bali', imagePath: 'assets/images/tari kecak.jpg', deskripsi: 'Tari seni pertunjukan drama tari khas Bali yang diiringi seruan kata "cak" secara berirama.'),
      2: LevelHasilData(namaBudaya: 'Tari Barong', daerah: 'Bali', imagePath: 'assets/images/barong.jpg', deskripsi: 'Tarian keagamaan dan hiburan yang melambangkan pertarungan abadi antara kebaikan dan kejahatan.'),
      3: LevelHasilData(namaBudaya: 'Upacara Ngaben', daerah: 'Bali', imagePath: 'assets/images/ngaben.jpg', deskripsi: 'Upacara kremasi atau pembakaran jenazah adat masyarakat Hindu di Bali.'),
      4: LevelHasilData(namaBudaya: 'Ogoh-Ogoh', daerah: 'Bali', imagePath: 'assets/images/ogoh ogoh.jpg', deskripsi: 'Karya seni patung boneka raksasa khas Bali yang diarak saat menyambut hari raya Nyepi.'),
      5: LevelHasilData(namaBudaya: 'Pura Bali', daerah: 'Bali', imagePath: 'assets/images/bali.jpg', deskripsi: 'Tempat ibadah Umat Hindu Bali dengan arsitektur gapura dan stupa yang khas.'),
    },
    'Kalimantan': {
      1: LevelHasilData(namaBudaya: 'Rumah Betang', daerah: 'Kalimantan Tengah', imagePath: 'assets/images/kalimantan.jpg', deskripsi: 'Rumah adat khas suku Dayak berupa rumah panggung panjang yang dihuni oleh puluhan keluarga.'),
      2: LevelHasilData(namaBudaya: 'Pasar Terapung', daerah: 'Kalimantan Selatan', imagePath: 'assets/images/pasar terapung.jpg', deskripsi: 'Pasar tradisional di atas permukaan air sungai menggunakan perahu kelotok khas Banjarmasin.'),
      3: LevelHasilData(namaBudaya: 'Tari Mandau', daerah: 'Kalimantan Tengah', imagePath: 'assets/images/tari mandau.jpg', deskripsi: 'Tarian prajurit suku Dayak yang memperagakan keahlian dan kegagahan mempermainkan senjata Mandau.'),
      4: LevelHasilData(namaBudaya: 'Telabang (Perisai)', daerah: 'Kalimantan', imagePath: 'assets/images/telabang.jpg', deskripsi: 'Perisai tradisional terbuat dari kayu ringan berpola ukiran khas Dayak yang unik.'),
      5: LevelHasilData(namaBudaya: 'Tato Dayak', daerah: 'Kalimantan', imagePath: 'assets/images/tato dayak.jpg', deskripsi: 'Seni rajah tubuh tradisional suku Dayak yang melambangkan status sosial dan perjalanan hidup.'),
    },
  };

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    String keySavedLevel = 'saved_${wilayah.toLowerCase()}_level';
    int currentSaved = prefs.getInt(keySavedLevel) ?? 1;

    // Hanya tambah skor 10 jika menyelesaikan level baru
    if (currentLevel >= currentSaved) {
      await prefs.setInt(keySavedLevel, currentLevel + 1);
      int totalPoints = prefs.getInt('total_user_score') ?? 0;
      await prefs.setInt('total_user_score', totalPoints + 10);
    }

    if (wilayah == 'Jawa' && currentLevel >= 5) {
      await prefs.setBool('sumatera_unlocked', true);
    } else if (wilayah == 'Sumatera' && currentLevel >= 5) {
      await prefs.setBool('bali_unlocked', true);
    } else if (wilayah == 'Bali' && currentLevel >= 5) {
      await prefs.setBool('kalimantan_unlocked', true);
    }
  }

  void _showInfoModal(BuildContext context, LevelHasilData data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                data.namaBudaya,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D1F6E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Asal: ${data.daerah}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A49E3),
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  data.imagePath,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 160,
                    width: double.infinity,
                    color: Colors.purple.shade100,
                    child: const Icon(Icons.collections, size: 48, color: Color(0xFF5A49E3)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                data.deskripsi,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A49E3),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Paham & Tutup', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<int, LevelHasilData> regionMap = hasilMapData[wilayah] ?? hasilMapData['Jawa']!;
    LevelHasilData data = regionMap[currentLevel] ?? regionMap[1]!;

    return Scaffold(
      backgroundColor: const Color(0xFF5A49E3),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFECE6F8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    size: 48,
                    color: Color(0xFF5A49E3),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Level Berhasil!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D1F6E),
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 4),
                    Text(
                      '+10 Poin',
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Koleksi baru:',
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F3FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          data.imagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 50,
                            height: 50,
                            color: Colors.purple.shade100,
                            child: const Icon(Icons.collections, color: Color(0xFF5A49E3)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.namaBudaya,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              data.daerah,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      _showInfoModal(context, data);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF5A49E3)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Lihat Informasi',
                      style: TextStyle(
                        color: Color(0xFF5A49E3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _saveProgress();
                      if (context.mounted) {
                        if (currentLevel < 5) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TantanganPage(wilayah: wilayah, level: currentLevel + 1),
                            ),
                            (route) => route.isFirst,
                          );
                        } else {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A49E3),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      currentLevel < 5 ? 'Lanjut Level ${currentLevel + 1}' : 'Selesai & Kembali ke Menu',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}