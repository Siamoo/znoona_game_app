import 'package:dartz/dartz.dart';
import 'package:znoona_game_app/features/quiz/room/data/datasources/room_remote_data_source.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/room_model.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/room_player_model.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/room_question_model.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_question.dart';
import 'package:znoona_game_app/features/quiz/room/domain/repositories/room_repository.dart';
import 'package:znoona_game_app/features/quiz/single/domain/entities/question.dart';

class RoomRepositoryImpl implements RoomRepository {
  RoomRepositoryImpl(this.remote);
  final RoomRemoteDataSource remote;

  /// 🏠 Create room with questions
  @override
  Future<Either<String, Room>> createRoom({
    required String categoryId,
  }) async {
    try {
      final roomModel = await remote.createRoom(
        categoryId: categoryId,
      );
      return Right(roomModel.toEntity());
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  /// 🚪 Join room
  @override
  Future<Either<String, RoomPlayer>> joinRoom({
    required String code,
  }) async {
    try {
      final playerModel = await remote.joinRoom(
        code: code,
      );
      return Right(playerModel.toEntity());
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  /// 🚶 Leave room
  @override
  Future<Either<String, void>> leaveRoom({
    required String roomId,
  }) async {
    try {
      await remote.leaveRoom(
        roomId: roomId,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  /// ♻️ Realtime stream of all rooms
  @override
  Stream<Either<String, List<Room>>> getRoomsStream() async* {
    try {
      await for (final rooms in remote.getRoomsStream()) {
        yield Right(
          rooms.map((m) => m.toEntity()).toList(),
        );
      }
    } on Exception catch (e) {
      yield Left(e.toString());
    }
  }

  /// 👥 Realtime stream of players in specific room
  @override
  Stream<Either<String, List<RoomPlayer>>> getRoomPlayersStream(
    String roomId,
  ) async* {
    try {
      await for (final players in remote.getRoomPlayersStream(roomId)) {
        yield Right(
          players.map((p) => p.toEntity()).toList(),
        );
      }
    } on Exception catch (e) {
      yield Left(e.toString());
    }
  }

  /// ❓ Load questions for room
  @override
  Future<Either<String, List<RoomQuestion>>> getRoomQuestions(
    String roomId,
  ) async {
    try {
      final questions = await remote.getRoomQuestions(roomId);
      return Right(
        questions.map((q) => q.toEntity()).toList(),
      );
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  /// 🚀 Start game (update status)
  @override
  Future<Either<String, void>> startGame(String roomId) async {
    try {
      await remote.startGame(roomId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  /// 🧭 Watch specific room in realtime
  @override
  Stream<Either<String, Room?>> watchRoom(String roomId) async* {
    try {
      await for (final room in remote.watchRoom(roomId)) {
        if (room == null) {
          yield const Right(null);
        } else {
          yield Right(room.toEntity());
        }
      }
    } on Exception catch (e) {
      yield Left(e.toString());
    }
  }

  /// ❓ Get multiple questions by IDs
  @override
  Future<Either<String, List<Question>>> getQuestions(
    List<String> questionIds,
  ) async {
    try {
      final questions = await remote.getQuestions(questionIds);
      return Right(questions);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> submitAnswer({
    required String roomId,
    required String userId,
    required String selectedAnswer,
    required bool isCorrect,
  }) async {
    try {
      await remote.submitAnswer(
        roomId: roomId,
        userId: userId,
        selectedAnswer: selectedAnswer,
        isCorrect: isCorrect,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, String>>> getPlayerAnswers(
    String roomId,
  ) async {
    try {
      final answers = await remote.getPlayerAnswers(roomId);
      return Right(answers);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> resetAnswersForNewQuestion(String roomId) async {
    try {
      await remote.resetAnswersForNewQuestion(roomId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Stream<Either<String, Map<String, String>>> watchPlayerAnswers(
    String roomId,
  ) async* {
    try {
      await for (final answers in remote.watchPlayerAnswers(roomId)) {
        yield Right(answers);
      }
    } on Exception catch (e) {
      yield Left('Error watching player answers: $e');
    }
  }
}
