import 'package:flutter/material.dart';

class FarmerNavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  String _selectedDrawerItem = 'Home';
  String? _profileImagePath;

  int get currentIndex => _currentIndex;
  String? get profileImagePath => _profileImagePath;
  String get selectedDrawerItem => _selectedDrawerItem;

  void setIndex(int index) {
    _currentIndex = index;
    // Update drawer selection based on index
    final items = ['Home', 'Marketplace', 'My Orders', 'Wallet', 'Profile'];
    if (index < items.length) {
      _selectedDrawerItem = items[index];
    } else {
      // For category pages (indices 5-8), keep marketplace selected
      _selectedDrawerItem = 'Marketplace';
    }
    notifyListeners();
  }

  void setDrawerItem(String item) {
    _selectedDrawerItem = item;
    // Update index based on drawer selection
    final items = ['Home', 'Marketplace', 'My Orders', 'Wallet', 'Profile'];
    final index = items.indexOf(item);
    if (index != -1) {
      _currentIndex = index;
    }
    notifyListeners();
  }

  void setTabIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void resetNavigation() {
    _currentIndex = 0;
    _selectedDrawerItem = 'Home';
    notifyListeners();
  }

  void setProfileImage(String? path) {
    _profileImagePath = path;
    notifyListeners();
  }
}
