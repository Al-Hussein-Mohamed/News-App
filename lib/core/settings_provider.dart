import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier{
  String _currentLanguage = "en";

  void changeLanguage(String newLanguage) {
    _currentLanguage = newLanguage;
    notifyListeners();
  }

  String get currentLanguage => _currentLanguage;

  bool isEn() => _currentLanguage == "en";
}