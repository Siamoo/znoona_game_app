import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/room_model.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/room_player_model.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/room_question_model.dart';
import 'package:znoona_game_app/features/quiz/single/data/models/question_model.dart';
import 'package:znoona_game_app/features/quiz/single/domain/entities/question.dart';

class RoomRemoteDataSource {
  RoomRemoteDataSource(this.supabase);
  final SupabaseClient supabase;

  Future<RoomModel> createRoom({
    required String categoryId,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final metadata = user.userMetadata ?? {};
    final userNameMeta = metadata['full_name'] ?? 'Host';

    final result = await supabase.rpc<dynamic>(
      'create_room_with_questions',
      params: {
        'p_category_id': categoryId,
        'p_host_id': user.id,
        'p_username': userNameMeta,
        'p_num_questions': 10,
      },
    );

    if (result == null) {
      throw Exception('Failed to create room: result is null');
    }

    final dynamic roomEntry = (result is List && result.isNotEmpty)
        ? result.first
        : result;

    final roomId = roomEntry?['room_id'];
    if (roomId == null || roomId is! String) {
      throw Exception('Invalid room_id returned: $roomId');
    }

    final data = await supabase
        .from('rooms')
        .select()
        .eq('id', roomId)
        .maybeSingle();

    if (data == null) {
      throw Exception('Room not found after creation (ID: $roomId)');
    }

    print('room json: $data');
    return RoomModel.fromJson(data);
  }

  Future<RoomPlayerModel> joinRoom({
    required String code,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final metadata = user.userMetadata ?? {};
    final userNameMeta = metadata['full_name'] ?? 'player';

    final roomData = await supabase
        .from('rooms')
        .select()
        .eq('code', code)
        .maybeSingle();

    if (roomData == null) throw Exception('Room not found with code $code');

    final roomId = roomData['id'];
    if (roomId == null || roomId is! String) {
      throw Exception('Invalid room ID in roomData: $roomData');
    }

    final playerData = await supabase
        .from('room_players')
        .insert({
          'room_id': roomId,
          'user_id': user.id,
          'username': userNameMeta,
          'is_host': false,
          'is_connected': true,
          'score': 0,
        })
        .select()
        .maybeSingle();

    if (playerData == null) throw Exception('Failed to join room');

    return RoomPlayerModel.fromJson(playerData);
  }

  Future<void> leaveRoom({
    required String roomId,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await supabase.from('room_players').delete().match({
      'room_id': roomId,
      'user_id': user.id,
    });
    print('🔚leaveRoom user-- playerData: $user');
  }

  Stream<List<RoomModel>> getRoomsStream() {
    print('getRoomsStream');
    return supabase
        .from('rooms')
        .stream(primaryKey: ['id'])
        .map(
          (rows) => rows.map((e) => RoomModel.fromJson(e)).toList(),
        );
  }

  Stream<List<RoomPlayerModel>> getRoomPlayersStream(String roomId) {
    print(' getRoomPlayersStream roomId: $roomId');
    return supabase
        .from('room_players')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .map(
          (rows) => rows.map((e) => RoomPlayerModel.fromJson(e)).toList(),
        );
  }

  Future<List<RoomQuestionModel>> getRoomQuestions(String roomId) async {
    final data = await supabase
        .from('room_questions')
        .select()
        .eq('room_id', roomId)
        .order('order_index', ascending: true);

    print(' getRoomQuestions data: $data');

    return (data as List)
        .map((e) => RoomQuestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> startGame(String roomId) async {
    print(' startGame roomId: $roomId');
    await supabase.from('rooms').update({'status': 'playing'}).eq('id', roomId);
  }

  Stream<RoomModel?> watchRoom(String roomId) {
    print(' watchRoom roomId: $roomId');
    return supabase
        .from('rooms')
        .stream(primaryKey: ['id'])
        .eq('id', roomId)
        .map((rows) => rows.isNotEmpty ? RoomModel.fromJson(rows.first) : null);
  }

  Future<List<Question>> getQuestions(List<String> questionIds) async {
    if (questionIds.isEmpty) return [];

    final data = await supabase
        .from('questions')
        .select()
        .inFilter('id', questionIds);

    print(' getQuestions data: $data');

    return (data as List)
        .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
        .map((model) => model.toEntity())
        .toList();
  }

  Future<void> submitAnswer({
    required String roomId,
    required String userId,
    required String selectedAnswer,
    required bool isCorrect,
  }) async {
    final playerData = await supabase
        .from('room_players')
        .select('score')
        .eq('room_id', roomId)
        .eq('user_id', userId)
        .single();

    final currentScore = playerData['score'] as int? ?? 0;
    final newScore = isCorrect ? currentScore + 10 : currentScore;

    await supabase
        .from('room_players')
        .update({
          'selected_answer': selectedAnswer,
          'is_correct': isCorrect,
          'score': newScore,
          'answered_at': DateTime.now().toIso8601String(),
        })
        .eq('room_id', roomId)
        .eq('user_id', userId);
  }

  Future<Map<String, String>> getPlayerAnswers(String roomId) async {
    final data = await supabase
        .from('room_players')
        .select('user_id, selected_answer, is_correct')
        .eq('room_id', roomId)
        .not('selected_answer', 'is', null);

    final Map<String, String> answers = {};
    for (final item in data) {
      answers[item['user_id'] as String] = item['selected_answer'] as String;
    }

    return answers;
  }

  Future<void> resetAnswersForNewQuestion(String roomId) async {
    print(' RESET: Resetting answers for room: $roomId');

    try {
      final result = await supabase
          .from('room_players')
          .update({
            'selected_answer': null,
            'is_correct': null,
            'answered_at': null,
          })
          .eq('room_id', roomId)
          .select();

      print(' RESET: Database update completed');
      print(' RESET: Affected rows: ${result.length}');

      final verification = await supabase
          .from('room_players')
          .select('user_id, selected_answer')
          .eq('room_id', roomId);

      final nonNullAnswers = verification
          .where((row) => row['selected_answer'] != null)
          .toList();
      print(
        ' RESET: Answers after reset - non-null: ${nonNullAnswers.length}',
      );
    } catch (e) {
      print(' RESET ERROR: $e');
      throw Exception('Failed to reset answers: $e');
    }
  }

  Stream<Map<String, String>> watchPlayerAnswers(String roomId) {
    final startTime = DateTime.now();

    return supabase
        .from('room_players')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .map((List<Map<String, dynamic>> rows) {
          final Map<String, String> answers = {};

          for (final row in rows) {
            final userId = row['user_id']?.toString();
            final selectedAnswer = row['selected_answer']?.toString();
            final answeredAt = row['answered_at']?.toString();

            if (userId != null &&
                selectedAnswer != null &&
                answeredAt != null) {
              final answerTime = DateTime.tryParse(answeredAt);
              if (answerTime != null &&
                  answerTime.isAfter(
                    startTime.subtract(const Duration(seconds: 5)),
                  )) {
                answers[userId] = selectedAnswer;
              }
            }
          }

          return answers;
        });
  }

  Future<void> markPlayerFinished({
    required String roomId,
    required String userId,
    required int finalScore,
  }) async {
    final finishedAt = DateTime.now().toIso8601String();
    print('🕒 Setting finished_at: $finishedAt');

    try {
      final result = await supabase
          .from('room_players')
          .update({
            'finished_quiz': true,
            'finished_at': finishedAt,
            'score': finalScore,
          })
          .eq('room_id', roomId)
          .eq('user_id', userId)
          .select();

      print('✅ Database update result: $result');

      if (result != null && result.isNotEmpty) {
        final updatedPlayer = result.first;
        print(
          '🔍 Updated player - finished_quiz: ${updatedPlayer['finished_quiz']}, '
          'finished_at: ${updatedPlayer['finished_at']}',
        );
      }
    } catch (e) {
      print('❌ Database update error: $e');
      rethrow;
    }
  }

  Future<void> fixBrokenFinishedAt({
    required String roomId,
    required String userId,
  }) async {
    try {
      final currentData = await supabase
          .from('room_players')
          .select()
          .eq('room_id', roomId)
          .eq('user_id', userId)
          .single();

      print(
        '🔧 Checking player state: '
        'finished_quiz: ${currentData['finished_quiz']}, '
        'finished_at: ${currentData['finished_at']}',
      );

      if (currentData['finished_quiz'] == true &&
          currentData['finished_at'] == null) {
        final fixedTime = DateTime.now().toIso8601String();
        print('🛠️ Fixing broken finished_at: $fixedTime');

        await supabase
            .from('room_players')
            .update({
              'finished_at': fixedTime,
            })
            .eq('room_id', roomId)
            .eq('user_id', userId);

        print('✅ Fixed broken finished_at');
      }
    } catch (e) {
      print('❌ Error fixing broken finished_at: $e');
    }
  }

  Stream<List<RoomPlayerModel>> getRoomPlayersStreamForResults(String roomId) {
    print('🔍 Starting synchronized room players stream - Room: $roomId');

    return supabase
        .from('room_players')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .asyncMap((rows) async {
          print('📨 Stream received ${rows.length} players');

          // Add a small delay to ensure all updates are captured
          await Future.delayed(const Duration(milliseconds: 100));

          // Debug: Check each player's finished_at
          for (final row in rows) {
            print(
              '👤 Player: ${row['username']}, '
              'finished_quiz: ${row['finished_quiz']}, '
              'finished_at: ${row['finished_at']}',
            );
          }

          final players = rows.map((e) => RoomPlayerModel.fromJson(e)).toList();

          // Log finished players for debugging
          final finishedCount = players.where((p) => p.finishedQuiz).length;
          final finishedWithTimestamp = players
              .where((p) => p.finishedAt != null)
              .length;

          print(
            '🎯 Stream: $finishedCount/${players.length} players finished, '
            '$finishedWithTimestamp with timestamp',
          );

          return players;
        })
        .handleError((error) {
          print('❌ Stream error: $error');
          throw Exception('Stream error: $error');
        });
  }


  Future<List<RoomPlayerModel>> getRoomPlayers(String roomId) async {
    final data = await supabase
        .from('room_players')
        .select()
        .eq('room_id', roomId);

    return (data as List)
        .map((e) => RoomPlayerModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
