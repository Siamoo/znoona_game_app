import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/room_model.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/room_player_model.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/room_question_model.dart';
import 'package:znoona_game_app/features/quiz/single/data/models/question_model.dart';
import 'package:znoona_game_app/features/quiz/single/domain/entities/question.dart';

class RoomRemoteDataSource {
  RoomRemoteDataSource(this.supabase);
  final SupabaseClient supabase;

  ///  Create a new room (via Supabase RPC)
  Future<RoomModel> createRoom({
    required String categoryId,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final metadata = user.userMetadata ?? {};
    final userNameMeta = metadata['full_name'] ?? 'Host';

    final result = await supabase.rpc(
      'create_room_with_questions',
      params: {
        'p_category_id': categoryId,
        'p_host_id': user.id,
        'p_username': userNameMeta,
        'p_num_questions': 10,
      },
    );

    print('📦 create_room_with_questions result: $result');

    if (result == null) {
      throw Exception('Failed to create room: result is null');
    }

    // handle both list and map returns
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

    print('🔥 room json: $data');
    return RoomModel.fromJson(data);
  }

  ///  Join existing room by code
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

    print('📦 joinRoom roomData: $roomData');

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

    print('📦 joinRoom playerData: $playerData');

    if (playerData == null) throw Exception('Failed to join room');

    return RoomPlayerModel.fromJson(playerData);
  }

  /// 🚶 Leave a room
  Future<void> leaveRoom({
    required String roomId,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await supabase.from('room_players').delete().match({
      'room_id': roomId,
      'user_id': user.id,
    });
    print('📦 leaveRoom user-- playerData: $user');
  }

  /// ♻️ Stream all rooms
  Stream<List<RoomModel>> getRoomsStream() {
    print('📦 getRoomsStream');
    return supabase
        .from('rooms')
        .stream(primaryKey: ['id'])
        .map(
          (rows) => rows.map((e) => RoomModel.fromJson(e)).toList(),
        );
  }

  /// 👥 Stream all players in a room
  Stream<List<RoomPlayerModel>> getRoomPlayersStream(String roomId) {
    print('📦 getRoomPlayersStream roomId: $roomId');
    return supabase
        .from('room_players')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .map(
          (rows) => rows.map((e) => RoomPlayerModel.fromJson(e)).toList(),
        );
  }

  /// ❓ Get questions for a room
  Future<List<RoomQuestionModel>> getRoomQuestions(String roomId) async {
    final data = await supabase
        .from('room_questions')
        .select()
        .eq('room_id', roomId)
        .order('order_index', ascending: true);

    print('📦 getRoomQuestions data: $data');

    return (data as List)
        .map((e) => RoomQuestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 🚀 Start game
  Future<void> startGame(String roomId) async {
    print('📦 startGame roomId: $roomId');
    await supabase.from('rooms').update({'status': 'playing'}).eq('id', roomId);
  }

  /// 🧭 Watch single room
  Stream<RoomModel?> watchRoom(String roomId) {
    print('📦 watchRoom roomId: $roomId');
    return supabase
        .from('rooms')
        .stream(primaryKey: ['id'])
        .eq('id', roomId)
        .map((rows) => rows.isNotEmpty ? RoomModel.fromJson(rows.first) : null);
  }

  /// ❓ Get question by ID
  Future<Question> getQuestion(String questionId) async {
    final data = await supabase
        .from('questions')
        .select()
        .eq('id', questionId)
        .single();

    print('📦 getQuestion data: $data');

    // Use your existing QuestionModel from single feature
    final questionModel = QuestionModel.fromJson(data);
    return questionModel.toEntity();
  }

  /// ❓ Get multiple questions by IDs
  Future<List<Question>> getQuestions(List<String> questionIds) async {
    if (questionIds.isEmpty) return [];

    final data = await supabase
        .from('questions')
        .select()
        .inFilter('id', questionIds); // Use inFilter instead of in

    print('📦 getQuestions data: $data');

    // Use your existing QuestionModel from single feature
    return (data as List)
        .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
        .map((model) => model.toEntity())
        .toList();
  }

  /// ✅ Store player answer and update score in room_players table
  Future<void> submitAnswer({
    required String roomId,
    required String userId,
    required String selectedAnswer,
    required bool isCorrect,
  }) async {
    // Get current player data
    final playerData = await supabase
        .from('room_players')
        .select('score')
        .eq('room_id', roomId)
        .eq('user_id', userId)
        .single();

    final currentScore = playerData['score'] as int? ?? 0;
    final newScore = isCorrect ? currentScore + 10 : currentScore;

    // Update player's answer and score
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

  /// ✅ Get all player answers for current room
  Future<Map<String, String>> getPlayerAnswers(String roomId) async {
    final data = await supabase
        .from('room_players')
        .select('user_id, selected_answer, is_correct')
        .eq('room_id', roomId)
        .not('selected_answer', 'is', null); // FIXED: Correct NOT NULL check

    final Map<String, String> answers = {};
    for (final item in data) {
      answers[item['user_id'] as String] = item['selected_answer'] as String;
    }

    return answers;
  }

  /// ✅ Reset answers for new question
  /// ✅ Reset answers for new question
  /// ✅ Reset answers for new question
  Future<void> resetAnswersForNewQuestion(String roomId) async {
    print('🔄 RESET: Resetting answers for room: $roomId');

    try {
      // Use select() after update to verify the reset worked
      final result = await supabase
          .from('room_players')
          .update({
            'selected_answer': null,
            'is_correct': null,
            'answered_at': null,
          })
          .eq('room_id', roomId)
          .select(); // ADD THIS to get confirmation

      print('🔄 RESET: Database update completed');
      print('🔄 RESET: Affected rows: ${result.length}');

      // Verify the reset worked by checking current answers
      final verification = await supabase
          .from('room_players')
          .select('user_id, selected_answer')
          .eq('room_id', roomId);

      final nonNullAnswers = verification
          .where((row) => row['selected_answer'] != null)
          .toList();
      print(
        '🔄 RESET: Answers after reset - non-null: ${nonNullAnswers.length}',
      );
    } catch (e) {
      print('❌ RESET ERROR: $e');
      throw Exception('Failed to reset answers: $e');
    }
  }

  /// 🎯 Watch player answers with filtering
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

            // Only include answers from current question session
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
}
