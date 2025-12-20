import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/repositories/room_repository.dart';

class MarkPlayerFinishedUseCase {
  MarkPlayerFinishedUseCase(this.repository);
  final RoomRepository repository;

  Future<Either<String, void>> call({
    required String roomId,
    required String userId,
    required int finalScore,
  }) {
    return repository.markPlayerFinished(
      roomId: roomId,
      userId: userId,
      finalScore: finalScore,
    );
  }
}