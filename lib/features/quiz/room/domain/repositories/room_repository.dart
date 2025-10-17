import 'package:dartz/dartz.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_question.dart';
import 'package:znoona_game_app/features/quiz/single/domain/entities/question.dart';

abstract class RoomRepository {
  Future<Either<String, Room>> createRoom({
    required String categoryId,
    required int timerDuration,
  });

  Future<Either<String, RoomPlayer>> joinRoom({
    required String code,
  });

  Future<Either<String, void>> leaveRoom({
    required String roomId,
  });

  Stream<Either<String, List<Room>>> getRoomsStream();

  Stream<Either<String, List<RoomPlayer>>> getRoomPlayersStream(String roomId);

Future<Either<String, List<RoomQuestion>>> getRoomQuestions(String roomId);

  Future<Either<String, void>> startGame(String roomId);

  Stream<Either<String, Room?>> watchRoom(String roomId);


  Future<Either<String, List<Question>>> getQuestions(List<String> questionIds);


  Future<Either<String, void>> submitAnswer({
    required String roomId,
    required String userId,
    required String selectedAnswer,
    required bool isCorrect,
  });

  Future<Either<String, Map<String, String>>> getPlayerAnswers(String roomId);

  Future<Either<String, void>> resetAnswersForNewQuestion(String roomId);



  Stream<Either<String, Map<String, String>>> watchPlayerAnswers(String roomId);

  Future<Either<String, void>> markPlayerFinished({
  required String roomId,
  required String userId,
  required int finalScore,
});

Stream<Either<String, List<RoomPlayer>>> getRoomPlayersStreamForResults(String roomId);

Future<Either<String, List<RoomPlayer>>> getRoomPlayers(String roomId);


}

