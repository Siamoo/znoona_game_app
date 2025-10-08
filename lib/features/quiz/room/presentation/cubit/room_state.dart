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

  
}
extension RoomStateExtensions on RoomState {
  bool get isLoading => this is _Loading;
  
  bool get isError => maybeMap(
        error: (_) => true,
        orElse: () => false,
      );
  
  String? get errorMessage => maybeMap(
        error: (errorState) => errorState.message,
        orElse: () => null,
      );
}