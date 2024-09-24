import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/source_bar/source_manager/source_states.dart';

import '../../../../data/data_source/api_manager.dart';
import '../../../../models/source_model.dart';

class SourceCubit extends Cubit<SourceState> {
  SourceCubit() : super(DismissSourceState());

  List<Source> _sourcesList = [];
  int _idx = 0;
  bool _hide = false;

  static SourceCubit get(context) => BlocProvider.of<SourceCubit>(context);

  bool get hide => _hide;

  set idx(int value) {
    _idx = value;
    emit(SuccessSourceState(_sourcesList, _idx, _hide, true));
  }

  set hide(bool value) {
    _hide = value;
    emit(SuccessSourceState(_sourcesList, _idx, _hide, false));
  }

  Future<void> fetchSourcesList(String? categoryID, bool updateArticle) async {
    _idx = 0;
    emit(LoadingSourceState());
    try {
      _sourcesList = await ApiManager.fetchSourcesList(categoryID);
      emit(SuccessSourceState(_sourcesList, _idx, _hide, updateArticle));
    } catch (error) {
      emit(ErrorSourceState(error.toString()));
    }
  }
}
