import 'package:shared_preferences/shared_preferences.dart';

class Budaya {
  final String nama;
  final String daerah;
  final String wilayah;
  final String imagePath;
  final String deskripsi;
  final List<String> ciriKhas;
  final String kategori;

  const Budaya({
    required this.nama,
    required this.daerah,
    required this.wilayah,
    required this.imagePath,
    required this.deskripsi,
    required this.ciriKhas,
    this.kategori = 'Warisan Budaya',
  });

  String get gambar => imagePath;
  String get asal => daerah;
}

const List<Budaya> listBudayaData = [
  Budaya(
    nama: 'Batik',
    daerah: 'Jawa Tengah',
    wilayah: 'Jawa',
    imagePath: 'assets/images/batik.jpg',
    deskripsi: 'Batik merupakan salah satu warisan budaya Indonesia yang dibuat dengan teknik rintang lilin (malam).',
    ciriKhas: ['Motif beragam penuh makna', 'Menggunakan malam/lilin', 'Nilai filosofis tinggi'],
    kategori: 'Pakaian Adat',
  ),
  Budaya(
    nama: 'Wayang Kulit',
    daerah: 'Jawa Tengah',
    wilayah: 'Jawa',
    imagePath: 'assets/images/wayang.jpg',
    deskripsi: 'Seni pertunjukan bayangan tradisional menggunakan pahatan kulit lembu/kerbau.',
    ciriKhas: ['Dimainkan oleh Dalang', 'Diringi musik Gamelan', 'Tokoh Mahabharata/Ramayana'],
    kategori: 'Seni Pertunjukan',
  ),
  Budaya(
    nama: 'Rumah Gadang',
    daerah: 'Sumatera Barat',
    wilayah: 'Sumatera',
    imagePath: 'assets/images/rumah gadang.jpg',
    deskripsi: 'Rumah adat khas Minangkabau dengan atap bergonjong menyerupai tanduk kerbau.',
    ciriKhas: ['Atap bergonjong', 'Bangunan tahan gempa', 'Ukir arsitektur khas Minang'],
    kategori: 'Rumah Adat',
  ),
  Budaya(
    nama: 'Tari Saman',
    daerah: 'Aceh',
    wilayah: 'Sumatera',
    imagePath: 'assets/images/tari saman.jpg',
    deskripsi: 'Tarian khas suku Gayo yang mengandalkan tepukan tangan dan gerakan dada yang cepat dan serempak.',
    ciriKhas: ['Gerakan sangat kompak', 'Tanpa alat musik', 'Diakui UNESCO'],
    kategori: 'Seni Tari',
  ),
  Budaya(
    nama: 'Tari Kecak',
    daerah: 'Bali',
    wilayah: 'Bali',
    imagePath: 'assets/images/tari kecak.jpg',
    deskripsi: 'Pertunjukan seni drama tari khas Bali yang diiringi oleh seruan kata "cak" secara berirama.',
    ciriKhas: ['Diiringi puluhan penari pria', 'Ditarikan melingkar', 'Kisah Ramayana'],
    kategori: 'Seni Tari',
  ),
  Budaya(
    nama: 'Tari Barong',
    daerah: 'Bali',
    wilayah: 'Bali',
    imagePath: 'assets/images/barong.jpg',
    deskripsi: 'Tarian keagamaan khas Bali yang melambangkan pertarungan abadi antara kebajikan dan kejahatan.',
    ciriKhas: ['Wujud Singa Barong', 'Kental nuansa keagamaan', 'Diiringi Gamelan Bali'],
    kategori: 'Seni Pertunjukan',
  ),
  Budaya(
    nama: 'Rumah Betang',
    daerah: 'Kalimantan Tengah',
    wilayah: 'Kalimantan',
    imagePath: 'assets/images/kalimantan.jpg',
    deskripsi: 'Rumah adat khas suku Dayak berupa rumah panggung panjang yang dihuni oleh banyak keluarga.',
    ciriKhas: ['Berbentuk panggung tinggi', 'Bahan kayu ulin', 'Huni puluhan kepala keluarga'],
    kategori: 'Rumah Adat',
  ),
  Budaya(
    nama: 'Pasar Terapung',
    daerah: 'Kalimantan Selatan',
    wilayah: 'Kalimantan',
    imagePath: 'assets/images/pasar terapung.jpg',
    deskripsi: 'Pasar tradisional di atas permukaan air sungai menggunakan perahu kelotok khas Banjarmasin.',
    ciriKhas: ['Bertransaksi di atas perahu', 'Tradisi barter (Manatuk)', 'Aktif sejak subuh'],
    kategori: 'Tradisi',
  ),
  Budaya(
    nama: 'Candi Borobudur',
    daerah: 'Jawa Tengah',
    wilayah: 'Jawa',
    imagePath: 'assets/images/borobudur.jpg',
    deskripsi: 'Candi Buddha terbesar di dunia yang dibangun pada abad ke-8 oleh Kerajaan Syailendra.',
    ciriKhas: ['Struktur stupa bertingkat', 'Relief cerita Buddha', 'Keajaiban dunia'],
    kategori: 'Bangunan Bersejarah',
  ),
];

// Utility untuk Simpan/Hapus Favorit
class KoleksiManager {
  static const String _key = 'user_saved_budaya';

  static Future<List<String>> getSavedBudayaNames() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  static Future<bool> toggleBookmark(String namaBudaya) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> current = prefs.getStringList(_key) ?? [];
    bool isSaved = false;

    if (current.contains(namaBudaya)) {
      current.remove(namaBudaya);
      isSaved = false;
    } else {
      current.add(namaBudaya);
      isSaved = true;
    }

    await prefs.setStringList(_key, current);
    return isSaved;
  }
}