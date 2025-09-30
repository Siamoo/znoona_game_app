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

  Future<ProfileModel> loginWithGoogle();

  Future<void> logout();

  Future<ProfileModel?> getCurrentUser();
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

  @override
  Future<ProfileModel> loginWithGoogle() async {
    await client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'com.znoona://login-callback/',
    );

    // Wait for session change (redirect finishes)
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
      final insertedProfile = await client
          .from('profiles')
          .insert({
            'id': user.id,
            'full_name': user.userMetadata?['full_name'] ?? user.email,
            'avatar_url': user.userMetadata?['avatar_url'],
          })
          .select()
          .single();

      return ProfileModel.fromJson(insertedProfile);
    }

    return ProfileModel.fromJson(profileRes);
  }

  @override
  Future<void> logout() {
    return client.auth.signOut();
  }

  @override
  Future<ProfileModel?> getCurrentUser() async {
  final user = client.auth.currentUser;
  if (user == null) return null;

  final profileRes = await client
      .from('profiles')
      .select()
      .eq('id', user.id)
      .maybeSingle();

  if (profileRes == null) return null;

  return ProfileModel.fromJson(profileRes);
  }
}
