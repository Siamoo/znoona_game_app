part of 'questions_cubit.dart';

@freezed
class QuestionsState with _$QuestionsState {
  const factory QuestionsState.initial() = _Initial;
  const factory QuestionsState.loading() = _Loading;
  const factory QuestionsState.loaded(List<Question> questions) = _Loaded;
  const factory QuestionsState.error(String message) = _Error;
}
