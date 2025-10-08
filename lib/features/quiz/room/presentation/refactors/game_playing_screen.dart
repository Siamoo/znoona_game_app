import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_question.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/refactors/room_quiz_screen.dart';
import 'package:znoona_game_app/features/quiz/single/domain/entities/question.dart';

class GamePlayingScreen extends StatefulWidget {
  final Room room;

  const GamePlayingScreen({super.key, required this.room});

  @override
  State<GamePlayingScreen> createState() => _GamePlayingScreenState();
}

class _GamePlayingScreenState extends State<GamePlayingScreen> {
  List<Question> _questions = [];
  bool _isLoadingQuestions = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadRoomQuestions();
  }

  Future<void> _loadRoomQuestions() async {
    if (_isLoadingQuestions) return;

    // Check mounted before setState
    if (!mounted) return;
    setState(() {
      _isLoadingQuestions = true;
      _errorMessage = null;
    });

    try {
      final result = await context.read<RoomCubit>().getRoomQuestions(widget.room.id);

      // Check mounted before processing result
      if (!mounted) return;

      result.fold(
        (String failure) {
          if (!mounted) return;
          setState(() {
            _errorMessage = failure;
            _isLoadingQuestions = false;
          });
        },
        (List<RoomQuestion> roomQuestions) {
          final List<String> questionIds = roomQuestions.map((rq) => rq.questionId).toList();

          if (questionIds.isNotEmpty) {
            context.read<RoomCubit>().getQuestions(questionIds);
          } else {
            if (!mounted) return;
            setState(() {
              _errorMessage = 'No questions found for this room';
              _isLoadingQuestions = false;
            });
          }
        },
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to load questions: $e';
        _isLoadingQuestions = false;
      });
    }
  }

  void _loadQuestions(List<Question> questions) {
    // Check mounted before setState
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
              // Check mounted before setState
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
        appBar: AppBar(title: const Text('Game')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Failed to load questions'),
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

    // Use the new RoomQuizBody with multiplayer features
    return RoomQuizBody(
      room: widget.room,
      questions: _questions,
    );
  }
}