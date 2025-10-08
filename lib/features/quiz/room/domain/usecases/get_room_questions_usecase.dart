import 'package:dartz/dartz.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_question.dart';
import 'package:znoona_game_app/features/quiz/room/domain/repositories/room_repository.dart';


class GetRoomQuestionsUseCase {
  GetRoomQuestionsUseCase(this.repository);
  final RoomRepository repository;

  Future<Either<String, List<RoomQuestion>>> call(String roomId) {
    return repository.getRoomQuestions(roomId);
  }
}
