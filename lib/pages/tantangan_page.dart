import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/pages/hasil_game_page.dart';

class LevelConfig {
  final String namaBudaya;
  final String imagePath;
  final String petunjuk;

  const LevelConfig({
    required this.namaBudaya,
    required this.imagePath,
    required this.petunjuk,
  });
}

class TantanganPage extends StatefulWidget {
  final String wilayah;
  final int level;

  const TantanganPage({
    super.key,
    this.wilayah = 'Jawa',
    this.level = 1,
  });

  @override
  State<TantanganPage> createState() => _TantanganPageState();
}

class _TantanganPageState extends State<TantanganPage> {
  final Map<String, Map<int, LevelConfig>> allData = const {
    'Jawa': {
      1: LevelConfig(namaBudaya: 'Batik', imagePath: 'assets/images/batik.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      2: LevelConfig(namaBudaya: 'Wayang Kulit', imagePath: 'assets/images/wayang.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      3: LevelConfig(namaBudaya: 'Keris', imagePath: 'assets/images/keris.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      4: LevelConfig(namaBudaya: 'Reog Ponorogo', imagePath: 'assets/images/reog.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      5: LevelConfig(namaBudaya: 'Gamelan', imagePath: 'assets/images/gamelan.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
    },
    'Sumatera': {
      1: LevelConfig(namaBudaya: 'Rumah Gadang', imagePath: 'assets/images/rumah gadang.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      2: LevelConfig(namaBudaya: 'Kain Ulos', imagePath: 'assets/images/ulos.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      3: LevelConfig(namaBudaya: 'Jam Gadang', imagePath: 'assets/images/jam gadang.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      4: LevelConfig(namaBudaya: 'Danau Toba', imagePath: 'assets/images/danau toba.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      5: LevelConfig(namaBudaya: 'Candi Muara Takus', imagePath: 'assets/images/candi muara takus.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
    },
    'Bali': {
      1: LevelConfig(namaBudaya: 'Tari Kecak', imagePath: 'assets/images/tari kecak.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      2: LevelConfig(namaBudaya: 'Tari Barong', imagePath: 'assets/images/barong.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      3: LevelConfig(namaBudaya: 'Upacara Ngaben', imagePath: 'assets/images/ngaben.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      4: LevelConfig(namaBudaya: 'Ogoh-Ogoh', imagePath: 'assets/images/ogoh ogoh.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      5: LevelConfig(namaBudaya: 'Pura Bali', imagePath: 'assets/images/bali.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
    },
    'Kalimantan': {
      1: LevelConfig(namaBudaya: 'Rumah Betang', imagePath: 'assets/images/kalimantan.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      2: LevelConfig(namaBudaya: 'Pasar Terapung', imagePath: 'assets/images/pasar terapung.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      3: LevelConfig(namaBudaya: 'Tari Mandau', imagePath: 'assets/images/tari mandau.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      4: LevelConfig(namaBudaya: 'Telabang (Perisai)', imagePath: 'assets/images/telabang.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
      5: LevelConfig(namaBudaya: 'Tato Dayak', imagePath: 'assets/images/tato dayak.jpg', petunjuk: 'Pilih kepingan di bawah, lalu pasang ke lokasi yang pas!'),
    },
  };

  late List<int?> gridSlots;
  late List<int> trayPieces;

  int? selectedTrayIndex;
  bool isCompleted = false;
  ui.Image? loadedImage;
  bool hasErrorLoading = false;

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  void _initGame() {
    gridSlots = List.filled(9, null);
    trayPieces = [0, 1, 2, 3, 4, 5, 6, 7, 8]..shuffle();
    selectedTrayIndex = null;
    isCompleted = false;
    loadedImage = null;
    hasErrorLoading = false;

    Map<int, LevelConfig> currentRegionMap = allData[widget.wilayah] ?? allData['Jawa']!;
    LevelConfig config = currentRegionMap[widget.level] ?? currentRegionMap[1]!;
    _loadImage(config.imagePath);
  }

  Future<void> _loadImage(String path) async {
    try {
      final ByteData data = await rootBundle.load(path);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      if (mounted) {
        setState(() {
          loadedImage = frame.image;
          hasErrorLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          hasErrorLoading = true;
        });
      }
    }
  }

  void _onGridTap(int index) {
    if (isCompleted || selectedTrayIndex == null) return;

    setState(() {
      int selectedPiece = trayPieces[selectedTrayIndex!];

      if (selectedPiece == index) {
        gridSlots[index] = selectedPiece;
        trayPieces.removeAt(selectedTrayIndex!);
        selectedTrayIndex = null;
        _checkWinCondition();
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Posisi kepingan kurang tepat! Coba slot lain.'),
            duration: Duration(milliseconds: 800),
            backgroundColor: Colors.orange,
          ),
        );
        selectedTrayIndex = null;
      }
    });
  }

  void _onTrayTap(int index) {
    if (isCompleted) return;

    setState(() {
      if (selectedTrayIndex == index) {
        selectedTrayIndex = null;
      } else {
        selectedTrayIndex = index;
      }
    });
  }

  void _checkWinCondition() {
    bool win = true;
    for (int i = 0; i < gridSlots.length; i++) {
      if (gridSlots[i] != i) {
        win = false;
        break;
      }
    }
    setState(() {
      isCompleted = win && trayPieces.isEmpty;
    });
  }

  bool _isPieceInCorrectPlace(int gridIndex) {
    return gridSlots[gridIndex] == gridIndex;
  }

  @override
  Widget build(BuildContext context) {
    Map<int, LevelConfig> currentRegionMap = allData[widget.wilayah] ?? allData['Jawa']!;
    LevelConfig currentConfig = currentRegionMap[widget.level] ?? currentRegionMap[1]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A49E3),
        title: Text('${widget.wilayah} - Level ${widget.level}', style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: widget.level / 5,
              color: const Color(0xFF5A49E3),
              backgroundColor: Colors.purple.shade100,
            ),
            const SizedBox(height: 12),
            Text(
              'Tantangan ${currentConfig.namaBudaya}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              currentConfig.petunjuk,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF5A49E3), width: 3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: hasErrorLoading
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.image_not_supported, size: 48, color: Colors.red),
                                const SizedBox(height: 8),
                                Text(
                                  'Gambar ${currentConfig.imagePath}\nbelum ditambahkan!',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ],
                            )
                          : loadedImage == null
                              ? const Center(child: CircularProgressIndicator())
                              : GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                  ),
                                  itemCount: 9,
                                  itemBuilder: (context, index) {
                                    int? currentPiece = gridSlots[index];
                                    bool isThisCorrect = _isPieceInCorrectPlace(index);

                                    bool rightConnected = isThisCorrect &&
                                        (index % 3 < 2) &&
                                        _isPieceInCorrectPlace(index + 1);
                                    bool bottomConnected = isThisCorrect &&
                                        (index ~/ 3 < 2) &&
                                        _isPieceInCorrectPlace(index + 3);

                                    return GestureDetector(
                                      onTap: () => _onGridTap(index),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFECE6F8),
                                          border: Border(
                                            top: BorderSide(
                                              color: isThisCorrect ? Colors.transparent : Colors.white,
                                              width: 1.5,
                                            ),
                                            left: BorderSide(
                                              color: isThisCorrect ? Colors.transparent : Colors.white,
                                              width: 1.5,
                                            ),
                                            right: BorderSide(
                                              color: rightConnected ? Colors.transparent : Colors.white,
                                              width: 1.5,
                                            ),
                                            bottom: BorderSide(
                                              color: bottomConnected ? Colors.transparent : Colors.white,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        child: currentPiece != null
                                            ? CustomPaint(
                                                painter: TileCropPainter(
                                                  image: loadedImage!,
                                                  row: currentPiece ~/ 3,
                                                  col: currentPiece % 3,
                                                  opacity: 1.0,
                                                ),
                                              )
                                            : CustomPaint(
                                                painter: TileCropPainter(
                                                  image: loadedImage!,
                                                  row: index ~/ 3,
                                                  col: index % 3,
                                                  opacity: 0.25,
                                                ),
                                              ),
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (trayPieces.isNotEmpty && loadedImage != null)
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F0FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(trayPieces.length, (trayIdx) {
                      int pieceVal = trayPieces[trayIdx];
                      bool isSelected = selectedTrayIndex == trayIdx;

                      return GestureDetector(
                        onTap: () => _onTrayTap(trayIdx),
                        child: Container(
                          width: 65,
                          height: 65,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? Colors.amber : Colors.purple.shade300,
                              width: isSelected ? 3 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: CustomPaint(
                              painter: TileCropPainter(
                                image: loadedImage!,
                                row: pieceVal ~/ 3,
                                col: pieceVal % 3,
                                opacity: 1.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            if (isCompleted)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  '🎉 Luar Biasa! Puzzle ${currentConfig.namaBudaya} Berhasil Tersusun!',
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isCompleted
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HasilGamePage(wilayah: widget.wilayah, currentLevel: widget.level),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A49E3),
                  disabledBackgroundColor: Colors.grey.shade400,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  isCompleted ? 'Selesaikan Level' : 'Susun Puzzle Dahulu',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TileCropPainter extends CustomPainter {
  final ui.Image image;
  final int row;
  final int col;
  final double opacity;

  TileCropPainter({
    required this.image,
    required this.row,
    required this.col,
    this.opacity = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double pieceWidth = image.width / 3;
    final double pieceHeight = image.height / 3;

    final Rect src = Rect.fromLTWH(
      col * pieceWidth,
      row * pieceHeight,
      pieceWidth,
      pieceHeight,
    );

    final Rect dst = Rect.fromLTWH(0, 0, size.width, size.height);

    final Paint paint = Paint()..color = Colors.white.withValues(alpha: opacity);

    canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant TileCropPainter oldDelegate) {
    return oldDelegate.row != row ||
        oldDelegate.col != col ||
        oldDelegate.image != image ||
        oldDelegate.opacity != opacity;
  }
}