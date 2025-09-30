import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/features/user/auth/domain/entities/profile.dart';
import 'package:znoona_game_app/features/user/auth/presentation/screens/login_screen.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({required this.profile, super.key, });
 final Profile profile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(profile.avatarUrl!),
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
              const Spacer(),

              ElevatedButton(
                onPressed: () async {
                  await Supabase.instance.client.auth.signOut();
                  ZnoonaNavigate.pushReplacementTo(
                    context,
                    const LoginScreen(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
