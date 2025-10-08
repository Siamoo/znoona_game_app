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

  const factory RoomState.questionLoaded(Question question) = _QuestionLoaded;
  const factory RoomState.questionsListLoaded(List<Question> questions) =
      _QuestionsListLoaded;

  // NEW QUIZ STATES - UPDATED to include players
  const factory RoomState.quizStarted({
    required List<Question> questions,
    required int currentQuestionIndex,
    required int remainingTime,
    required Map<String, String?> playerAnswers, // playerId -> selectedAnswer
    required String? selectedAnswer, // current user's selected answer
    required int correctCount,
    required bool isWaitingForPlayers,
    required List<RoomPlayer> players, // ADD THIS LINE
  }) = _QuizStarted;

  const factory RoomState.questionTimeUp({
    required List<RoomPlayer> players, // ADD THIS LINE
  }) = _QuestionTimeUp;
  
  const factory RoomState.allPlayersAnswered({
    required List<RoomPlayer> players, // ADD THIS LINE
  }) = _AllPlayersAnswered;
  
  const factory RoomState.quizFinished({
    required int totalQuestions,
    required int correctAnswers,
    required List<RoomPlayer> players, // ADD THIS LINE
  }) = _QuizFinished;
}