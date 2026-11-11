import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/pages/tantangan_page.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int activeLevelJawa = 1;
  int activeLevelSumatera = 1;
  int activeLevelBali = 1;
  int activeLevelKalimantan = 1;

  bool isSumateraUnlocked = false;
  bool isBaliUnlocked = false;
  bool isKalimantanUnlocked = false;

  int totalScore = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    int savedJawa = prefs.getInt('saved_jawa_level') ?? 1;
    int savedSumatera = prefs.getInt('saved_sumatera_level') ?? 1;
    int savedBali = prefs.getInt('saved_bali_level') ?? 1;
    int savedKalimantan = prefs.getInt('saved_kalimantan_level') ?? 1;

    bool sumateraStatus = prefs.getBool('sumatera_unlocked') ?? false;
    bool baliStatus = prefs.getBool('bali_unlocked') ?? false;
    bool kalimantanStatus = prefs.getBool('kalimantan_unlocked') ?? false;

    int score = prefs.getInt('total_user_score') ?? 0;

    if (mounted) {
      setState(() {
        activeLevelJawa = savedJawa;
        activeLevelSumatera = savedSumatera;
        activeLevelBali = savedBali;
        activeLevelKalimantan = savedKalimantan;

        isSumateraUnlocked = sumateraStatus || savedJawa > 5;
        isBaliUnlocked = baliStatus || savedSumatera > 5;
        isKalimantanUnlocked = kalimantanStatus || savedBali > 5;

        totalScore = score;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A49E3),
        title: const Text('Jelajah Nusantara', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner Tampilan Total Skor Poin Pengguna
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF5A49E3), Color(0xFF7A68F8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5A49E3).withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.stars_rounded, color: Colors.amber, size: 36),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Skor Kamu',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$totalScore Poin',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Pilih wilayah yang ingin kamu jelajahi',
            style: TextStyle(color: Colors.black54, fontSize: 13),
          ),
          const SizedBox(height: 12),
          _buildRegionCard(
            context,
            title: 'Jawa',
            subtitle: activeLevelJawa > 5 ? '5/5 level selesai' : '$activeLevelJawa/5 level selesai',
            imagePath: 'assets/images/batik.jpg',
            isLocked: false,
            onTap: () async {
              int levelToPlay = activeLevelJawa > 5 ? 5 : activeLevelJawa;
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TantanganPage(wilayah: 'Jawa', level: levelToPlay),
                ),
              );
              _loadProgress();
            },
          ),
          const SizedBox(height: 12),
          _buildRegionCard(
            context,
            title: 'Sumatera',
            subtitle: activeLevelSumatera > 5
                ? '5/5 level selesai'
                : isSumateraUnlocked
                    ? '${activeLevelSumatera - 1}/5 level selesai'
                    : 'Terkunci',
            imagePath: 'assets/images/rumah gadang.jpg',
            isLocked: !isSumateraUnlocked,
            onTap: isSumateraUnlocked
                ? () async {
                    int levelToPlay = activeLevelSumatera > 5 ? 5 : activeLevelSumatera;
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TantanganPage(wilayah: 'Sumatera', level: levelToPlay),
                      ),
                    );
                    _loadProgress();
                  }
                : null,
          ),
          const SizedBox(height: 12),
          _buildRegionCard(
            context,
            title: 'Bali',
            subtitle: activeLevelBali > 5
                ? '5/5 level selesai'
                : isBaliUnlocked
                    ? '${activeLevelBali - 1}/5 level selesai'
                    : 'Terkunci',
            imagePath: 'assets/images/bali.jpg',
            isLocked: !isBaliUnlocked,
            onTap: isBaliUnlocked
                ? () async {
                    int levelToPlay = activeLevelBali > 5 ? 5 : activeLevelBali;
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TantanganPage(wilayah: 'Bali', level: levelToPlay),
                      ),
                    );
                    _loadProgress();
                  }
                : null,
          ),
          const SizedBox(height: 12),
          _buildRegionCard(
            context,
            title: 'Kalimantan',
            subtitle: activeLevelKalimantan > 5
                ? '5/5 level selesai'
                : isKalimantanUnlocked
                    ? '${activeLevelKalimantan - 1}/5 level selesai'
                    : 'Terkunci',
            imagePath: 'assets/images/kalimantan.jpg',
            isLocked: !isKalimantanUnlocked,
            onTap: isKalimantanUnlocked
                ? () async {
                    int levelToPlay = activeLevelKalimantan > 5 ? 5 : activeLevelKalimantan;
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TantanganPage(wilayah: 'Kalimantan', level: levelToPlay),
                      ),
                    );
                    _loadProgress();
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildRegionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String imagePath,
    required bool isLocked,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 70,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 70,
                  height: 60,
                  color: const Color(0xFFECE6F8),
                  child: const Icon(Icons.landscape, color: Color(0xFF5A49E3)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isLocked ? Colors.grey : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (isLocked)
                        const Icon(Icons.lock, size: 14, color: Colors.grey)
                      else
                        const Icon(Icons.location_on, size: 14, color: Color(0xFF5A49E3)),
                      const SizedBox(width: 4),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 12, color: isLocked ? Colors.grey : Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!isLocked)
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A49E3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Mulai', style: TextStyle(color: Colors.white)),
              )
            else
              const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}