part of 'room_cubit.dart'; 

@freezed
class RoomState with _$RoomState {
  const factory RoomState.initial() = _Initial;
  const factory RoomState.loading() = _Loading;
  const factory RoomState.error(String message) = _Error;

  const factory RoomState.roomLoaded(Room room) = _RoomLoaded;
  const factory RoomState.roomsUpdated(List<Room> rooms) = _RoomsUpdated;
  const factory RoomState.playersUpdated(List<RoomPlayer> players) =
      _PlayersUpdated;
  const factory RoomState.roomUpdated(Room? room) = _RoomUpdated;
  const factory RoomState.questionsLoaded(List<RoomQuestion> questions) =
      _QuestionsLoaded;

  const factory RoomState.joined(Room room) = _Joined;
  const factory RoomState.left() = _Left;
  const factory RoomState.gameStarted() = _GameStarted;

  const factory RoomState.questionsListLoaded(List<Question> questions) =
      _QuestionsListLoaded;

  const factory RoomState.quizStarted({
    required List<Question> questions,
    required int currentQuestionIndex,
    required int remainingTime,
    required Map<String, String?> playerAnswers,
    required String? selectedAnswer,
    required int correctCount,
    required bool isWaitingForPlayers,
    required List<RoomPlayer> players,
  }) = _QuizStarted;

  const factory RoomState.playerFinished({
    required int totalQuestions,
    required int correctAnswers,
    required int totalPlayers,
    required int finishedPlayers,
  }) = _PlayerFinished;

  const factory RoomState.showingProgressiveResults({
    required List<PlayerResult> results,
    required int finishedPlayers,
    required int totalPlayers,
    required bool allPlayersFinished,
    required int userRank,
  }) = _ShowingProgressiveResults;

  const factory RoomState.quizFinished({
    required int totalQuestions,
    required int correctAnswers,
    required List<RoomPlayer> players,
  }) = _QuizFinished;
}
