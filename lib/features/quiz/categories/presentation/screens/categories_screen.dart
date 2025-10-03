import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:znoona_game_app/core/di/injcetion_container.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/cubit/categories_cubit.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/refactors/categories_body.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CategoriesCubit>()..loadCategories(),
      child: const CategoriesBody(),
    );
  }
}
