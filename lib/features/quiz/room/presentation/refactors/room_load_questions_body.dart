import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_question.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/screen/room_quiz_screen.dart';
import 'package:znoona_game_app/features/quiz/single/domain/entities/question.dart';

class GamePlayingBody extends StatefulWidget {
  const GamePlayingBody({required this.room, super.key});
  final Room room;

  @override
  State<GamePlayingBody> createState() => _GamePlayingBodyState();
}

class _GamePlayingBodyState extends State<GamePlayingBody> {
  List<Question> _questions = [];
  bool _isLoadingQuestions = false;
  String? _errorMessage;

  @override
  Future<void> initState() async {
    super.initState();
    await _loadRoomQuestions();
  }

  Future<void> _loadRoomQuestions() async {
    if (_isLoadingQuestions) return;

    if (!mounted) return;
    setState(() {
      _isLoadingQuestions = true;
      _errorMessage = null;
    });

    try {
      final result = await context.read<RoomCubit>().getRoomQuestions(
        widget.room.id,
      );

      if (!mounted) return;
     await result.fold(
        (String failure) {
          if (!mounted) return;
          setState(() {
            _errorMessage = failure;
            _isLoadingQuestions = false;
          });
        },
        (List<RoomQuestion> roomQuestions) async {
          final questionIds = roomQuestions.map((rq) => rq.questionId).toList();

          if (questionIds.isNotEmpty) {
            await context.read<RoomCubit>().getQuestions(questionIds);
          } else {
            if (!mounted) return;
            setState(() {
              _errorMessage = 'No questions found for this room';
              _isLoadingQuestions = false;
            });
          }
        },
      );
    }on Exception catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to load questions: $e';
        _isLoadingQuestions = false;
      });
    }
  }

  void _loadQuestions(List<Question> questions) {
    if (!mounted) return;
    setState(() {
      _questions = questions;
      _isLoadingQuestions = false;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomCubit, RoomState>(
      listener: (context, state) {
        state.whenOrNull(
          questionsListLoaded: (questions) {
            if (_questions.isEmpty) {
              _loadQuestions(questions);
            }
          },
          error: (String message) {
            if (_isLoadingQuestions) {
              if (!mounted) return;
              setState(() {
                _errorMessage = message;
                _isLoadingQuestions = false;
              });
            }
          },
        );
      },
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_isLoadingQuestions) {
      return Scaffold(
        appBar: AppBar(title: const Text('Game')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomAppBar(title: 'Game'),
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Failed to load questions'),
              const SizedBox(height: 8),
              Text(_errorMessage!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadRoomQuestions,
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Game')),
        body: const Center(child: Text('No questions available')),
      );
    }

    return RoomQuizScreen(
      room: widget.room,
      questions: _questions,
    );
  }
}
