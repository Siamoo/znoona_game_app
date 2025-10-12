import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/entities/category.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/cubit/categories_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/refactors/room_lobby_screen.dart';

class RoomCreationScreen extends StatefulWidget {
  const RoomCreationScreen({super.key});

  @override
  State<RoomCreationScreen> createState() => _RoomCreationScreenState();
}

class _RoomCreationScreenState extends State<RoomCreationScreen> {
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    // Load categories when screen opens
    context.read<CategoriesCubit>().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Room'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          // Handle room creation success
          BlocListener<RoomCubit, RoomState>(
            listener: (context, state) {
              state.whenOrNull(
                roomLoaded: (room) {
                  // Navigate to room lobby when room is created
                  ZnoonaNavigate.pushReplacementTo(
                    context,
                    RoomLobbyPage(room: room),
                  );
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                },
              );
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              const Text(
                'Create New Game Room',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose a category and start playing with friends!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Category Selection
              const Text(
                'Select Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              // Categories List
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const _LoadingCategories(),
                    loading: () => const _LoadingCategories(),
                    loaded: (categories) => _CategoryGrid(
                      categories: categories,
                      selectedCategory: _selectedCategory,
                      onCategorySelected: (category) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                    error: (message) => _ErrorWidget(message: message),
                  );
                },
              ),

              const Spacer(),

              // Create Room Button
              BlocBuilder<RoomCubit, RoomState>(
                builder: (context, state) {
                  final isLoading = state.maybeMap(
                    loading: (_) => true,
                    orElse: () => false,
                  );

                  return ElevatedButton(
                    onPressed: isLoading || _selectedCategory == null
                        ? null
                        : () {
                            context.read<RoomCubit>().createRoom(
                              categoryId: _selectedCategory!.id,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).primaryColor,
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : const Text(
                            'Create Room',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Loading State for Categories
class _LoadingCategories extends StatelessWidget {
  const _LoadingCategories();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

// Categories Grid
class _CategoryGrid extends StatelessWidget {
  final List<Category> categories;
  final Category? selectedCategory;
  final dynamic Function(Category) onCategorySelected;

  const _CategoryGrid({
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final isSelected = selectedCategory?.id == category.id;

        return GestureDetector(
          onTap: () => onCategorySelected(category),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor.withOpacity(0.2)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // You can add category icons here
                Icon(
                  Icons.category,
                  size: 40,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade600,
                ),
                const SizedBox(height: 8),
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Error Widget for Categories
class _ErrorWidget extends StatelessWidget {
  final String message;

  const _ErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 40),
          const SizedBox(height: 8),
          Text(
            'Failed to load categories',
            style: TextStyle(
              color: Colors.red.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: TextStyle(color: Colors.red.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context.read<CategoriesCubit>().loadCategories(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
            ),
            child: const Text(
              'Try Again',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
