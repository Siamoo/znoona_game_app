import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/room_model.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/room_player_model.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/room_question_model.dart';

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
    final userNameMeta = metadata['full_name'] ?? 'username';

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
    final userNameMeta = metadata['username'] ?? 'username';

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
          (rows) => rows
              .map((e) => RoomModel.fromJson(e as Map<String, dynamic>))
              .toList(),
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
          (rows) => rows
              .map((e) => RoomPlayerModel.fromJson(e as Map<String, dynamic>))
              .toList(),
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
        .eq('id', roomId) // Use 'id' instead of 'code'
        .map((rows) => rows.isNotEmpty ? RoomModel.fromJson(rows.first) : null);
  }

  
}
