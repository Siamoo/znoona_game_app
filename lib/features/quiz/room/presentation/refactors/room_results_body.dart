import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_linear_button.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/quiz/room/data/models/player_result.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/widgets/results/results_list.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/widgets/results/user_rank_card.dart';

class RoomResultsBody extends StatelessWidget {
  const RoomResultsBody({required this.roomId, super.key});
  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RoomCubit, RoomState>(
        listener: (context, state) {
          state.whenOrNull(
            showingProgressiveResults:
                (
                  results,
                  finishedPlayers,
                  totalPlayers,
                  allFinished,
                  userRank,
                ) {
                  // Celebration logic can be added here if needed
                },
            left: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            showingProgressiveResults:
                (
                  results,
                  finishedPlayers,
                  totalPlayers,
                  allFinished,
                  userRank,
                ) {
                  return ProgressiveResultsBody(
                    results: results,
                    finishedPlayers: finishedPlayers,
                    totalPlayers: totalPlayers,
                    allPlayersFinished: allFinished,
                    userRank: userRank,
                    roomId: roomId,
                  );
                },
            error: (message) {
              return ErrorScreen(
                message: message,
                onRetry: () {
                  context.read<RoomCubit>().markPlayerFinished(
                    roomId: roomId,
                    finalScore: 0,
                    correctAnswers: 0,
                    totalQuestions: 10,
                  );
                },
              );
            },
            orElse: () => const LoadingScreen(),
          );
        },
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading results...'),
        ],
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    required this.message,
    required this.onRetry,
    super.key,
  });
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressiveResultsBody extends StatelessWidget {
  const ProgressiveResultsBody({
    required this.results,
    required this.finishedPlayers,
    required this.totalPlayers,
    required this.allPlayersFinished,
    required this.userRank,
    required this.roomId,
    super.key,
  });
  final List<PlayerResult> results;
  final int finishedPlayers;
  final int totalPlayers;
  final bool allPlayersFinished;
  final int userRank;
  final String roomId;

  @override
  Widget build(BuildContext context) {
    final currentUserResult = results.firstWhere(
      (r) => r.isCurrentUser,
      orElse: () => results.first,
    );

    final rankedGroups = _groupPlayersByRank(results);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ZnoonaColors.containerLinear2(context),
            ZnoonaColors.main(context),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 40.h),
        child: Column(
          children: [
            UserRankCard(userResult: currentUserResult, results: results),
            const SizedBox(height: 20),
            Expanded(
              child: ResultsList(
                rankedGroups: rankedGroups,
                results: results,
                finishedPlayers: finishedPlayers,
                totalPlayers: totalPlayers,
              ),
            ),
            if (allPlayersFinished) ActionButtons(roomId: roomId),
          ],
        ),
      ),
    );
  }

  Map<int, List<PlayerResult>> _groupPlayersByRank(List<PlayerResult> results) {
    final groups = <int, List<PlayerResult>>{};
    for (final result in results) {
      if (result.rank > 0) {
        groups.putIfAbsent(result.rank, () => []).add(result);
      }
    }
    return groups;
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({required this.roomId, super.key});
  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Card(
        color: ZnoonaColors.main(context).withAlpha(150),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              Text(
                'Game Complete',
                style: GoogleFonts.beiruti(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: ZnoonaColors.text(context),
                ),
              ),
              const SizedBox(height: 12),
              CustomLinearButton(
                width: double.infinity,
                height: 50.h,
                onPressed: () async {
                  context.read<RoomCubit>().leaveFromAllRooms();
                  Navigator.pop(context);
                },
                child: Text(
                  ZnoonaTexts.tr(
                    context,
                    LangKeys.leaveRoom,
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
