import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_app_bar.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room_question.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/screen/room_quiz_screen.dart';
import 'package:medaan_almaarifa/features/quiz/single/domain/entities/question.dart';

class RoomLoadQuestionsBody extends StatefulWidget {
  const RoomLoadQuestionsBody({required this.room, super.key});
  final Room room;

  @override
  State<RoomLoadQuestionsBody> createState() => _RoomLoadQuestionsBodyState();
}

class _RoomLoadQuestionsBodyState extends State<RoomLoadQuestionsBody> {
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
              _errorMessage = ZnoonaTexts.tr(context, LangKeys.noQuestionsFound);
              _isLoadingQuestions = false;
            });
          }
        },
      );
    } on Exception catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = '${ZnoonaTexts.tr(context, LangKeys.failedToLoadQuestions)}: $e';
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
        appBar: AppBar(title: Text(ZnoonaTexts.tr(context, LangKeys.quizGame))),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomAppBar(title: 'Game'), // This needs to be fixed too
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(ZnoonaTexts.tr(context, LangKeys.failedToLoadQuestions)),
              const SizedBox(height: 8),
              Text(_errorMessage!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadRoomQuestions,
                child: Text(ZnoonaTexts.tr(context, LangKeys.tryAgain)),
              ),
            ],
          ),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(ZnoonaTexts.tr(context, LangKeys.quizGame))),
        body: Center(child: Text(ZnoonaTexts.tr(context, LangKeys.noQuestionsAvailable))),
      );
    }

    return RoomQuizScreen(
      room: widget.room,
      questions: _questions,
    );
  }
}