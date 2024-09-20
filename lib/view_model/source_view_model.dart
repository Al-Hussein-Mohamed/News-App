import 'package:flutter/material.dart';

import '../../../models/source_model.dart';
import '../data/data_source/api_manager.dart';

class SourceViewModel extends ChangeNotifier{
  List<Source> _sourcesList = [];
  int _idx = 0;

  int get idx => _idx;
  List<Source> get sourcesList => _sourcesList;


  set idx(int value) {
    _idx = value;
    notifyListeners();
  }

  Future<void> fetchSourcesList(String? categoryID) async {
    _idx = 0;
    _sourcesList = await ApiManager.fetchSourcesList(categoryID??"");
    notifyListeners();
  }
}