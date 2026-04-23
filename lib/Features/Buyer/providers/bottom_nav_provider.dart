import 'package:flutter/foundation.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  String? _profileImagePath;

  int get currentIndex => _currentIndex;
  String? get profileImagePath => _profileImagePath;

  void setIndex(int index) {
    if (index == _currentIndex) return;
    _currentIndex = index;
    notifyListeners();
  }

  void setProfileImage(String? path) {
    _profileImagePath = path;
    notifyListeners();
  }
}
