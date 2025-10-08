import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_question.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/create_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_room_players_stream_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_room_questions_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_rooms_stream_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/join_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/leave_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/start_game_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/watch_room_usecase.dart';



part 'room_state.dart';
part 'room_cubit.freezed.dart';

class RoomCubit extends Cubit<RoomState> {

  RoomCubit({
    required this.createRoomUseCase,
    required this.joinRoomUseCase,
    required this.leaveRoomUseCase,
    required this.getRoomsStreamUseCase,
    required this.getRoomPlayersStreamUseCase,
    required this.getRoomQuestionsUseCase,
    required this.startGameUseCase,
    required this.watchRoomUseCase,
  }) : super(const RoomState.initial());
  final CreateRoomUseCase createRoomUseCase;
  final JoinRoomUseCase joinRoomUseCase;
  final LeaveRoomUseCase leaveRoomUseCase;
  final GetRoomsStreamUseCase getRoomsStreamUseCase;
  final GetRoomPlayersStreamUseCase getRoomPlayersStreamUseCase;
  final GetRoomQuestionsUseCase getRoomQuestionsUseCase;
  final StartGameUseCase startGameUseCase;
  final WatchRoomUseCase watchRoomUseCase;

  StreamSubscription<dynamic>? _roomsSub;
  StreamSubscription<dynamic>? _playersSub;
 StreamSubscription<dynamic>? _roomWatcher;
 StreamSubscription<dynamic>? _roomsSubscription;

  // 🔹 إنشاء روم جديد
  Future<void> createRoom({
    required String categoryId,
  }) async {
    emit(const RoomState.loading());

    final result = await createRoomUseCase(categoryId: categoryId);

    result.fold(
      (failure) {
        emit(RoomState.error(failure));
        print('❌ Create room failed: $failure');
      },
      (room) async {
        print('✅ Room created: ${room.id} (${room.code})');

        watchRoom(room.id);
        watchRoomPlayers(room.id);

        emit(RoomState.roomLoaded(room));
      },
    );
  }

  // 🔹 الانضمام إلى روم
  Future<void> joinRoom({required String code}) async {
    emit(const RoomState.loading());

    final result = await joinRoomUseCase(code: code);

    result.fold(
      (failure) => emit(RoomState.error(failure)),
      (_) {
        // إلغاء أي اشتراك سابق لتفادي تكرار الأحداث
        _roomsSubscription?.cancel();

        _roomsSubscription = getRoomsStreamUseCase().listen((either) {
          if (isClosed) return; // 🔹 تأكد قبل أي emit

          either.fold(
            (failure) => emit(RoomState.error(failure)),
            (rooms) {
              try {
                final room = rooms.firstWhere((r) => r.code == code);
                print('✅ Joined room found: ${room.id}');

                // نبدأ المراقبة
                watchRoom(room.id);
                watchRoomPlayers(room.id);

                emit(RoomState.joined(room));
              } catch (_) {
                emit(const RoomState.error('Room not found!'));
              }
            },
          );
        });
      },
    );
  }

  // 🔹 مغادرة الروم
  Future<void> leaveRoom({
    required String roomId,
  }) async {
    // إلغاء جميع الاشتراكات الحالية لتفادي التحديث بعد الإغلاق
    await _roomsSubscription?.cancel();
    await _roomsSub?.cancel();
    await _playersSub?.cancel();
    await _roomWatcher?.cancel();

    _roomsSubscription = null;
    _roomsSub = null;
    _playersSub = null;
    _roomWatcher = null;

    final result = await leaveRoomUseCase(roomId: roomId);

    if (isClosed) return; // 🔹 حماية إضافية من emit بعد الإغلاق

    result.fold(
      (failure) => emit(RoomState.error(failure)),
      (_) {
        print('🧭 leaveRoom');
        emit(const RoomState.left());
      },
    );
  }

  // 🔹 مراقبة جميع الغرف
  void watchRooms() {
    _roomsSub?.cancel();
    _roomsSub = getRoomsStreamUseCase().listen((either) {
      if (isClosed) return; // 🔹 تأكد قبل emit
      either.fold(
        (failure) {
          emit(RoomState.error(failure));
          print(failure);
        },
        (rooms) {
          print('🧭 watchRooms update: ${rooms.length}');
          emit(RoomState.roomsUpdated(rooms));
        },
      );
    });
  }

  // 🔹 مراقبة لاعبي الروم
  void watchRoomPlayers(String roomId) {
    _playersSub?.cancel();
    _playersSub = getRoomPlayersStreamUseCase(roomId).listen((either) {
      if (isClosed) return;
      either.fold(
        (failure) => emit(RoomState.error(failure)),
        (players) {
          print('🧭 watchRoomPlayers update: ${players.length}');
          emit(RoomState.playersUpdated(players));
        },
      );
    });
  }

  // 🔹 مراقبة حالة الروم
  void watchRoom(String roomId) {
    _roomWatcher?.cancel();
    _roomWatcher = watchRoomUseCase(roomId).listen((either) {
      if (isClosed) return;
      either.fold(
        (failure) => emit(RoomState.error(failure)),
        (room) {
          if (room == null) {
            print('⚠️ watchRoom returned null (temporary)');
            return;
          }

          print('🧭 watchRoom update: ${room.status}');
          if (room.status == 'started') {
            emit(const RoomState.gameStarted());
          } else {
            emit(RoomState.roomUpdated(room));
          }
        },
      );
    });
  }

  // 🔹 بدء اللعبة
  Future<void> startGame(String roomId) async {
    final result = await startGameUseCase(roomId);
    if (isClosed) return;
    result.fold(
      (failure) => emit(RoomState.error(failure)),
      (_) {
        print('🚀 Game started!');
        emit(const RoomState.gameStarted());
      },
    );
  }

  // 🔹 تحميل أسئلة الروم
  Future<void> getRoomQuestions(String roomId) async {
    emit(const RoomState.loading());
    final result = await getRoomQuestionsUseCase(roomId);
    if (isClosed) return;
    result.fold(
      (failure) => emit(RoomState.error(failure)),
      (questions) => emit(RoomState.questionsLoaded(questions)),
    );
  }

  @override
  Future<void> close() async {
    print('🧹 Cleaning up RoomCubit...');
    await _roomsSubscription?.cancel();
    await _roomsSub?.cancel();
    await _playersSub?.cancel();
    await _roomWatcher?.cancel();
    _roomsSubscription = null;
    _roomsSub = null;
    _playersSub = null;
    _roomWatcher = null;
    return super.close();
  }
}
