import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medaan_almaarifa/features/home/refactors/home_body.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/cubit/auth_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
          authenticated: (profile, authMethod) => HomeBody(profile: profile), 
          orElse: () {
            return Container();
          },
        );
      },
    );
  }
}