import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/features/user/auth/presentation/screens/login_screen.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:znoona_game_app/features/user/auth/presentation/cubit/auth_cubit.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    // final profile = context.select<AuthCubit, dynamic>(
    //   (cubit) => cubit.state.maybeWhen(
    //     authenticated: (profile) => profile,
    //     orElse: () => null,
    //   ),
    // );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await Supabase.instance.client.auth.signOut();
                ZnoonaNavigate.pushReplacementTo(context, const LoginScreen());
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
