import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/category_model.dart';
import 'package:provider/provider.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(DefaultHomeState());

  bool _isCategorySheetOpened = false;
  bool _isSearch = false;
  CategoryModel? selectedCategory;

  static HomeCubit get(context) => Provider.of<HomeCubit>(context);

  bool get isCategorySheetOpened => _isCategorySheetOpened;

  bool get isSearch => _isSearch;

  void openCategorySheet() {
    _isCategorySheetOpened = true;
    emit(DefaultHomeState());
  }

  void closeCategorySheet() {
    _isCategorySheetOpened = false;
    emit(DefaultHomeState());
  }

  set isSearch(bool value) {
    if (_isSearch == value) return;
    _isSearch = value;
    emit(DefaultHomeState());
  }
}
