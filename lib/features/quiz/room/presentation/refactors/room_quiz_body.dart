import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_view/photo_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medaan_almaarifa/core/app/app_cubit/app_cubit.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_app_bar.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room_player.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/screen/room_results_screen.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/widgets/Quiz/empty_quiz_body.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/widgets/Quiz/room_game_header.dart';
import 'package:medaan_almaarifa/features/quiz/single/domain/entities/question.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/widgets/option_button.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RoomQuizBody extends StatefulWidget {
  const RoomQuizBody({
    required this.room,
    required this.questions,
    super.key,
  });
  final Room room;
  final List<Question> questions;

  @override
  State<RoomQuizBody> createState() => _RoomQuizBodyState();
}

class _RoomQuizBodyState extends State<RoomQuizBody> {
  List<Question> _currentQuestions = [];
  int _currentQuestionIndex = 0;
  Map<String, String?> _currentPlayerAnswers = {};
  String? _currentSelectedAnswer;
  int _currentCorrectCount = 0;
  List<RoomPlayer> _currentPlayers = [];
  bool _hasPlayedTimerWarning = false;

  @override
  void initState() {
    super.initState();
    _currentQuestions = widget.questions;
    _currentPlayers = [];
    context.read<RoomCubit>().startQuiz(widget.questions);
    context.read<RoomCubit>().watchPlayerAnswers(widget.room.id);
  }

  // Audio helper methods
  Future<void> _playCorrectSound() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isSoundEnabled) {
      await GetIt.I<AudioService>().playCorrectSound();
    }
  }

  Future<void> _playWrongSound() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isSoundEnabled) {
      await GetIt.I<AudioService>().playWrongSound();
    }
  }

  Future<void> _playTimerWarningSound() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isSoundEnabled) {
      await GetIt.I<AudioService>().playTimerWarningSound();
    }
  }

  Future<void> _playWinSound() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isSoundEnabled) {
      await GetIt.I<AudioService>().playWinSound();
    }
  }

  Future<void> _playGoodResultSound() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isSoundEnabled) {
      await GetIt.I<AudioService>().playGoodResultSound();
    }
  }

  Future<void> _playBadResultSound() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isSoundEnabled) {
      await GetIt.I<AudioService>().playBadResultSound();
    }
  }

  String? _convertGoogleDriveUrl(String? url) {
    if (url == null || url.isEmpty) return null;

    if (url.contains('drive.google.com')) {
      final regex = RegExp(r'/d/([a-zA-Z0-9_-]+)');
      final match = regex.firstMatch(url);

      if (match != null) {
        final fileId = match.group(1);
        return 'https://drive.google.com/uc?export=view&id=$fileId';
      }
    }

    return url;
  }

  void _showFullScreenImage(String imageUrl) {
    // Check if the image URL is valid before showing
    if (imageUrl.isEmpty) return;

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (context) => Dialog.fullscreen(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            PhotoView(
              imageProvider: CachedNetworkImageProvider(imageUrl),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 3,
              initialScale: PhotoViewComputedScale.contained,
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              loadingBuilder: (context, event) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: ZnoonaColors.main(context),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Loading image...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        size: 60.sp,
                        color: Colors.white54,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Failed to load image',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'The image may have been moved or deleted',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
              heroAttributes: PhotoViewHeroAttributes(
                tag: imageUrl,
                transitionOnUserGestures: true,
              ),
              enableRotation: true,
              basePosition: Alignment.center,
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 10.h,
              right: 20.w,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 20.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'Pinch to zoom • Double tap to reset',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Rotate device for landscape view',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 11.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectAnswer(String answer) async {
    final currentUserId = _getCurrentUserId();
    final currentQuestion = _currentQuestions[_currentQuestionIndex];
    final appState = context.read<AppCubit>().state;

    // Check if user already answered
    if (_currentPlayerAnswers.containsKey(currentUserId) &&
        _currentPlayerAnswers[currentUserId] != null) {
      return;
    }

    _currentSelectedAnswer = answer;
    _currentPlayerAnswers = Map<String, String?>.from(_currentPlayerAnswers);
    _currentPlayerAnswers[currentUserId] = answer;

    final isCorrect = answer == currentQuestion.correctAnswer;
    if (isCorrect) {
      _currentCorrectCount++;
      if (appState.isSoundEnabled) {
        await _playCorrectSound();
      }
    } else {
      if (appState.isSoundEnabled) {
        await _playWrongSound();
      }
    }

    _emitQuizState();

    // Submit answer to database
    await context.read<RoomCubit>().selectAnswer(answer);
  }

void _checkTimerWarning(int remainingTime) {
  if (remainingTime <= 3 && remainingTime > 0 && !_hasPlayedTimerWarning) {
    _hasPlayedTimerWarning = true;
    _playTimerWarningSound();
  }
}

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomCubit, RoomState>(
      listener: (context, state) {
        state.whenOrNull(
          quizStarted:
              (
                questions,
                currentQuestionIndex,
                remainingTime,
                playerAnswers,
                selectedAnswer,
                correctCount,
                isWaitingForPlayers,
                players,
              ) {
                // **FIX: Reset timer warning flag when question index changes**
                if (_currentQuestionIndex != currentQuestionIndex) {
                  _hasPlayedTimerWarning = false;
                }
                
                // Check for timer warning
                _checkTimerWarning(remainingTime);
                
                final mutablePlayerAnswers = Map<String, String?>.from(
                  playerAnswers,
                );
                setState(() {
                  _currentQuestions = questions;
                  _currentQuestionIndex = currentQuestionIndex;
                  _currentPlayerAnswers = mutablePlayerAnswers;
                  _currentSelectedAnswer = selectedAnswer;
                  _currentCorrectCount = correctCount;
                  _currentPlayers = players;
                });
              },

          quizFinished: (totalQuestions, correctAnswers, players) {
            // Play result sound based on performance
            _playQuizFinishedSound(correctAnswers, totalQuestions);
            _navigateToResultsScreen();
          },
        );
      },
      child: BlocBuilder<RoomCubit, RoomState>(
        builder: (context, state) {
          return state.maybeWhen(
            quizStarted:
                (
                  questions,
                  currentQuestionIndex,
                  remainingTime,
                  playerAnswers,
                  selectedAnswer,
                  correctCount,
                  isWaitingForPlayers,
                  players,
                ) {
                  return _buildQuizContent(
                    questions: questions,
                    currentQuestionIndex: currentQuestionIndex,
                    remainingTime: remainingTime,
                    playerAnswers: playerAnswers,
                    selectedAnswer: selectedAnswer,
                    correctCount: correctCount,
                    players: players,
                  );
                },
            orElse: () => _buildQuizContent(
              questions: _currentQuestions,
              currentQuestionIndex: _currentQuestionIndex,
              remainingTime: widget.room.timerDuration,
              playerAnswers: _currentPlayerAnswers,
              selectedAnswer: _currentSelectedAnswer,
              correctCount: _currentCorrectCount,
              players: _currentPlayers,
            ),
          );
        },
      ),
    );
  }

  Future<void> _playQuizFinishedSound(int correctAnswers, int totalQuestions) async {
    final appState = context.read<AppCubit>().state;
    if (!appState.isSoundEnabled) return;
    
    final double scorePercentage = correctAnswers / totalQuestions * 100;
    
    if (scorePercentage >= 70) {
      await _playWinSound();
    } else if (scorePercentage >= 50) {
      await _playGoodResultSound();
    } else {
      await _playBadResultSound();
    }
  }

  void _navigateToResultsScreen() {
    Future.delayed(const Duration(milliseconds: 800), () async {
      if (mounted) {
        await ZnoonaNavigate.pushReplacementTo(
          context,
          RoomResultsScreen(roomId: widget.room.id),
        );
      }
    });
  }

  void _emitQuizState() {
    if (mounted) {
      setState(() {});
    }
  }

  String _getCurrentUserId() {
    final user = Supabase.instance.client.auth.currentUser;
    return user?.id ?? 'unknown';
  }

  Widget _buildQuizContent({
    required List<Question> questions,
    required int currentQuestionIndex,
    required int remainingTime,
    required Map<String, String?> playerAnswers,
    required String? selectedAnswer,
    required int correctCount,
    required List<RoomPlayer> players,
  }) {
    if (questions.isEmpty) {
      return EmptyQuizBody(roomCode: widget.room.code);
    }

    final question = questions[currentQuestionIndex];
    final currentUserId = _getCurrentUserId();
    final hasAnswered =
        playerAnswers.containsKey(currentUserId) &&
        playerAnswers[currentUserId] != null;
    final imageUrl = _convertGoogleDriveUrl(question.image);

    return Scaffold(
      body: Column(
        children: [
          // Fixed header section
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  CustomAppBar(
                    title: LangKeys.room,
                    icon: Icons.close,
                    onTap: () {
                      ZnoonaNavigate.pop(context);
                      context.read<RoomCubit>().leaveFromAllRooms();
                    },
                    otherText:
                        '${currentQuestionIndex + 1}  ${ZnoonaTexts.tr(context, LangKeys.from)}  ${questions.length}  ${ZnoonaTexts.tr(context, LangKeys.question)}',
                  ),

                  RoomGameHeader(
                    context: context,
                    remainingTime: remainingTime,
                    playerAnswers: playerAnswers,
                    players: players,
                    correctCount: correctCount,
                    totalQuestions: questions.length,
                    currentUserId: currentUserId,
                  ),
                  SizedBox(height: 20.sp),
                ],
              ),
            ),
          ),

          // Scrollable content section
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => _showFullScreenImage(imageUrl),
                          child: Hero(
                            tag: imageUrl,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                placeholder: (context, url) => Container(
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: ZnoonaColors.main(context),
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) {
                                  return Container(
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image_not_supported,
                                            size: 50.sp,
                                            color: ZnoonaColors.text(
                                              context,
                                            ).withOpacity(0.5),
                                          ),
                                          SizedBox(height: 10.h),
                                          Text(
                                            'Image not available',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: ZnoonaColors.text(
                                                context,
                                              ).withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.sp),
                      ],
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        question.question,
                        style: GoogleFonts.scheherazadeNew(
                          fontSize: imageUrl != null && imageUrl.isNotEmpty
                              ? 20.sp
                              : 22.sp,
                          fontWeight: FontWeight.bold,
                          color: ZnoonaColors.text(context),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.sp),
                      ...question.options.map((option) {
                        final isSelected = option == selectedAnswer;
                        final isCorrect = option == question.correctAnswer;

                        return OptionButton(
                          option: option,
                          isSelected: isSelected,
                          selectedAnswer: selectedAnswer,
                          onTap: hasAnswered
                              ? null
                              : () => _selectAnswer(option),
                          isCorrect: isCorrect,
                          remainingTime: remainingTime,
                        );
                      }),
                      SizedBox(height: 20.sp),
                      
                      // Add sound control at bottom
                      _buildSoundControl(),
                      
                      SizedBox(height: 20.sp),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoundControl() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return Container(
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: ZnoonaColors.main(context).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                appState.isSoundEnabled ? Icons.volume_up : Icons.volume_off,
                color: ZnoonaColors.text(context),
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                appState.isSoundEnabled ? 'الصوت مفعل' : 'الصوت معطل',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ZnoonaColors.text(context),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => context.read<AppCubit>().toggleSound(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: ZnoonaColors.main(context),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    appState.isSoundEnabled ? 'إيقاف الصوت' : 'تشغيل الصوت',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}