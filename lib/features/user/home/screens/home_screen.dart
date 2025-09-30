import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:znoona_game_app/features/user/auth/presentation/cubit/auth_cubit.dart';
import 'package:znoona_game_app/features/user/home/refactors/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
          authenticated: (profile) => HomeBody(profile: profile),
          googleauthenticated: (profile) => HomeBody(profile: profile),
          orElse: () {
            return Container();
          },
        );
      },
    );
  }
}
