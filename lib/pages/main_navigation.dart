import 'package:flutter/material.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/pages/home_page.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/pages/budaya_page.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/pages/game_page.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/pages/info_page.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;
  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = const [
    HomePage(),
    BudayaPage(),
    GamePage(),
    InfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF5A49E3),
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Budaya',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_esports_rounded),
              label: 'Game',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_rounded),
              label: 'Info',
            ),
          ],
        ),
      ),
    );
  }
}