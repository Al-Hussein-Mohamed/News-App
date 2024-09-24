import '../../../../models/source_model.dart';

sealed class SourceState {}

class DismissSourceState extends SourceState {}
class LoadingSourceState extends SourceState {}

class ErrorSourceState extends SourceState {
  final String? error;

  ErrorSourceState(this.error);
}

class SuccessSourceState extends SourceState {
  final List<Source> sourcesList;
  final int idx;
  final bool hide;
  final bool fetch;
  SuccessSourceState(this.sourcesList, this.idx, this.hide, this.fetch);
}
