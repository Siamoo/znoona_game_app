import 'package:medaan_almaarifa/features/user/auth/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<ProfileModel> signUp({
    required String email,
    required String password,
    required String fullName,
    String? username,
  });

  Future<ProfileModel> login({
    required String email,
    required String password,
  });

  Future<ProfileModel> loginWithGoogle();

  Future<void> logout();

  Future<ProfileModel?> getCurrentUser();

  Future<ProfileModel> updateProfile({
    required String id,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? level,
  });

  Future<void> updatePlayerStats({
    required String userId,
    required bool won,
    required int score,
    String? categoryId,
  });

  Future<List<ProfileModel>> getLeaderboard({
    required String type,
    int limit = 50,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this.client);
  final SupabaseClient client;

  @override
  Future<ProfileModel> signUp({
    required String email,
    required String password,
    required String fullName,
    String? username,
  }) async {
    final authRes = await client.auth.signUp(
      email: email,
      password: password,
    );

    if (authRes.user == null) throw Exception('Sign up failed');

    final userId = authRes.user!.id;

    // Generate username if not provided
    final generatedUsername = username ?? _generateUsername(email, fullName);

    final profileRes = await client
        .from('profiles')
        .insert({
          'id': userId,
          'full_name': fullName,
          'level': 0,
          'email': email,
          'username': generatedUsername,
          'last_month_reset': DateTime.now().toIso8601String(),
        })
        .select()
        .single();

    return ProfileModel.fromJson(profileRes);
  }

  @override
  Future<ProfileModel> login({
    required String email,
    required String password,
  }) async {
    final authRes = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (authRes.user == null) throw Exception('Login failed');

    await _checkMonthlyReset(authRes.user!.id);

    final profileRes = await client
        .from('profiles')
        .select()
        .eq('id', authRes.user!.id)
        .single();

    return ProfileModel.fromJson(profileRes);
  }

  @override
  Future<ProfileModel> loginWithGoogle() async {
    await client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'com.znoona://login-callback/',
    );

    final session = await client.auth.onAuthStateChange.firstWhere(
      (event) => event.session != null,
    );

    final user = session.session!.user;

    final profileRes = await client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (profileRes == null) {
      final username = _generateUsername(
        user.email!,
        user.userMetadata?['full_name'].toString() ?? user.email!,
      );

      final insertedProfile = await client
          .from('profiles')
          .insert({
            'id': user.id,
            'full_name': user.userMetadata?['full_name'] ?? user.email,
            'avatar_url': user.userMetadata?['avatar_url'],
            'level': 0,
            'email': user.email,
            'username': username,
            'last_month_reset': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      return ProfileModel.fromJson(insertedProfile);
    }

    await _checkMonthlyReset(user.id);

    return ProfileModel.fromJson(profileRes);
  }

  @override
  Future<ProfileModel?> getCurrentUser() async {
    final user = client.auth.currentUser;
    if (user == null) return null;

    await _checkMonthlyReset(user.id);

    final profileRes = await client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (profileRes == null) return null;

    return ProfileModel.fromJson(profileRes);
  }

  @override
  Future<void> logout() {
    return client.auth.signOut();
  }

  @override
  Future<void> updatePlayerStats({
    required String userId,
    required bool won,
    required int score,
    String? categoryId,
  }) async {
    await client.rpc(
      'update_player_stats',
      params: {
        'p_user_id': userId,
        'p_won': won,
        'p_score': score,
        'p_category_id': categoryId,
      },
    );
  }

  @override
  Future<List<ProfileModel>> getLeaderboard({
    required String type,
    int limit = 50,
  }) async {
    final query = client
        .from('profiles')
        .select()
        .order(
          type == 'monthly' ? 'cups_by_month' : 'all_cups',
          ascending: false,
        )
        .limit(limit);

    final results = await query;
    return results.map((json) => ProfileModel.fromJson(json)).toList();
  }

  String _generateUsername(String email, String fullName) {
    // Use email prefix if available
    String base;
    if (email.contains('@')) {
      base = email.split('@').first;
    } else {
      base = fullName.split(' ').first;
    }

    // Clean the base (remove special chars, keep only a-z, 0-9)
    base = base.replaceAll(RegExp('[^a-zA-Z0-9]'), '').toLowerCase();

    // Ensure minimum length of 3
    if (base.length < 3) {
      base = 'player';
    }

    // Limit to 10 characters (leaves room for counter)
    if (base.length > 10) {
      base = base.substring(0, 10);
    }

    // Add random numbers (1-999)
    final random = DateTime.now().millisecondsSinceEpoch % 999 + 1;
    final username = '$base$random';

    // Final check: ensure max 12 characters
    return username.length > 12 ? username.substring(0, 12) : username;
  }

  Future<void> _checkMonthlyReset(String userId) async {
    await client.rpc(
      'check_monthly_reset',
      params: {
        'p_user_id': userId,
      },
    );
  }

  @override
  Future<ProfileModel> updateProfile({
    required String id,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? level,
  }) async {
    final updateData = <String, dynamic>{};

    if (username != null) {
      // Validate username length (3-12 characters)
      if (username.length < 3) {
        throw Exception('Username must be at least 3 characters');
      }
      if (username.length > 12) {
        throw Exception('Username cannot exceed 12 characters');
      }

      // Validate username format (only alphanumeric and underscores)
      if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
        throw Exception(
          'Username can only contain letters, numbers, and underscores',
        );
      }

      // Check if username is unique
      final existing = await client
          .from('profiles')
          .select('id')
          .eq('username', username)
          .neq('id', id)
          .maybeSingle();

      if (existing != null) {
        throw Exception('Username already taken');
      }

      updateData['username'] = username;
    }

    if (fullName != null) updateData['full_name'] = fullName;
    if (avatarUrl != null) updateData['avatar_url'] = avatarUrl;
    if (level != null) updateData['level'] = level;

    final profileRes = await client
        .from('profiles')
        .update(updateData)
        .eq('id', id)
        .select()
        .single();

    return ProfileModel.fromJson(profileRes);
  }
}
