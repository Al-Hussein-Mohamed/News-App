import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/title/title_manager/title_states.dart';
import 'package:provider/provider.dart';

class TitleCubit extends Cubit<TitleState> {
  TitleCubit() : super(DefaultTitleState());

  String? _title;

  static TitleCubit get(context) => Provider.of<TitleCubit>(context);
  String? get title => _title;

  set title(String? value) {
    _title = value;
    emit(DefaultTitleState());
  }
}
