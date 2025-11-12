import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/entities/category.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/usecases/get_main_categories_usecase.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/usecases/get_sub_categories_usecase.dart';

part 'categories_state.dart';
part 'categories_cubit.freezed.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({
    required this.getMainCategoriesUseCase,
    required this.getSubCategoriesUseCase,
  }) : super(const CategoriesState.initial());

  final GetMainCategoriesUseCase getMainCategoriesUseCase;
  final GetSubCategoriesUseCase getSubCategoriesUseCase;

  // Load all categories (original function)

  // Load main categories (parent_id is null)
  Future<void> loadMainCategories() async {
    emit(const CategoriesState.loading());
    
    final result = await getMainCategoriesUseCase();
    
    result.fold(
      (error) => emit(CategoriesState.error(error)),
      (categories) => emit(CategoriesState.loaded(categories)),
    );
  }

  // Load subcategories by parent ID
  Future<void> loadSubCategories(String parentId) async {
    emit(const CategoriesState.loading());
    
    final result = await getSubCategoriesUseCase(parentId);
    
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