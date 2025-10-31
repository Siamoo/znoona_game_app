import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/entities/category.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/usecases/get_categories_usecase.dart';

part 'categories_state.dart';
part 'categories_cubit.freezed.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({
    required this.getCategoriesUseCase,
  }) : super(const CategoriesState.initial());

  final GetCategoriesUseCase getCategoriesUseCase;


  // Load all categories (original function)
  Future<void> loadCategories() async {
    emit(const CategoriesState.loading());
    
    final result = await getCategoriesUseCase();
    
    result.fold(
      (error) => emit(CategoriesState.error(error)),
      (categories) => emit(CategoriesState.loaded(categories)),
    );
  }



  // Reset to initial state
  void reset() {
    emit(const CategoriesState.initial());
  }
}