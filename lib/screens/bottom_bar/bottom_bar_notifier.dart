import 'package:flutter/material.dart';
import 'package:smartcards/screens/dashboard/dashboard_screen.dart';
import 'package:smartcards/screens/scan/scan_screen.dart';
import 'package:smartcards/screens/search/search_screen.dart';

class BottomBarNotifier extends ChangeNotifier{
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  BottomBarNotifier(int? currentIndex) {
    _currentIndex = currentIndex ?? 0;
  }

  void changeTab(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final List<Widget> _screens = [
    DashboardScreen(),
    ScanScreen(),
    SearchScreen(),
  ];

  Widget get currentScreen => _screens[_currentIndex];
}