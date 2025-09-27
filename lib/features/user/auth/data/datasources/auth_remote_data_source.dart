import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/features/user/auth/data/models/profile_model.dart';

abstract class AuthRemoteDataSource {
  Future<ProfileModel> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<ProfileModel> login({
    required String email,
    required String password,
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
  }) async {
    final authRes = await client.auth.signUp(
      email: email,
      password: password,
    );

    if (authRes.user == null) throw Exception('Sign up failed');

    final userId = authRes.user!.id;

    final profileRes = await client
        .from('profiles')
        .insert({
          'id': userId,
          'full_name': fullName,
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

    final profileRes = await client
        .from('profiles')
        .select()
        .eq('id', authRes.user!.id)
        .single();

    return ProfileModel.fromJson(profileRes);
  }
}
