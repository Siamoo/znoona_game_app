import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/player_result.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';

class ProgressiveResultsScreen extends StatelessWidget {
  final String roomId;
  
  const ProgressiveResultsScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        leading: Container(), // Remove back button
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<RoomCubit, RoomState>(
        listener: (context, state) {
          state.whenOrNull(
            showingProgressiveResults: (results, finishedPlayers, totalPlayers, allFinished, userRank) {
              if (allFinished) {
                // Optional: Show celebration when all finish
                Future.delayed(const Duration(seconds: 2), () {
                  _showAllFinishedCelebration(context);
                });
              }
            },
            left: () {
              // Handle if user leaves room from results screen
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
            playerFinished: (totalQuestions, correctAnswers, totalPlayers, finishedPlayers) {
              return _WaitingForPlayersScreen(
                totalQuestions: totalQuestions,
                correctAnswers: correctAnswers,
                totalPlayers: totalPlayers,
                finishedPlayers: finishedPlayers,
              );
            },
            showingProgressiveResults: (results, finishedPlayers, totalPlayers, allFinished, userRank) {
              return _ProgressiveResultsBody(
                results: results,
                finishedPlayers: finishedPlayers,
                totalPlayers: totalPlayers,
                allPlayersFinished: allFinished,
                userRank: userRank,
                roomId: roomId,
              );
            },
            error: (message) {
              return _ErrorScreen(
                message: message,
                onRetry: () {
                  // You might want to retry loading results
                  context.read<RoomCubit>().markPlayerFinished(
                    roomId: roomId,
                    finalScore: 0, // These would need to be stored somewhere
                    correctAnswers: 0,
                    totalQuestions: 10,
                  );
                },
              );
            },
            orElse: () => const _LoadingScreen(),
          );
        },
      ),
    );
  }

  void _showAllFinishedCelebration(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.celebration, color: Colors.amber),
            SizedBox(width: 8),
            Text('All Players Finished!'),
          ],
        ),
        content: const Text('The final results are in! 🎉'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('View Results'),
          ),
        ],
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

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

class _ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorScreen({
    required this.message,
    required this.onRetry,
  });

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

class _WaitingForPlayersScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final int totalPlayers;
  final int finishedPlayers;

  const _WaitingForPlayersScreen({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.totalPlayers,
    required this.finishedPlayers,
  });

  @override
  Widget build(BuildContext context) {
    final progress = finishedPlayers / totalPlayers;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated celebration icon
            Icon(
              Icons.celebration,
              size: 80,
              color: _getCelebrationColor(progress),
            ),
            const SizedBox(height: 20),
            
            // Title
            Text(
              'Quiz Completed! 🎉',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // User's score
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Text(
                'Your Score: $correctAnswers/$totalQuestions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // Progress indicator
            Stack(
              alignment: Alignment.center,
              children: [
                // Background circle
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                ),
                // Progress circle
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getProgressColor(progress),
                    ),
                  ),
                ),
                // Progress text
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$finishedPlayers/$totalPlayers',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'players',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            
            // Status message
            Text(
              _getStatusMessage(progress),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            // Detailed progress
            Text(
              '$finishedPlayers out of $totalPlayers players finished',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            
            // Players finished indicator with animation
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getProgressColor(progress).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _getProgressColor(progress)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.group,
                    color: _getProgressColor(progress),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Waiting for ${totalPlayers - finishedPlayers} more player${totalPlayers - finishedPlayers == 1 ? '' : 's'}',
                    style: TextStyle(
                      color: _getProgressColor(progress),
                      fontWeight: FontWeight.w600,
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

  Color _getProgressColor(double progress) {
    if (progress < 0.3) return Colors.orange;
    if (progress < 0.7) return Colors.blue;
    return Colors.green;
  }

  Color _getCelebrationColor(double progress) {
    if (progress < 0.3) return Colors.orange;
    if (progress < 0.7) return Colors.blue;
    return Colors.green;
  }

  String _getStatusMessage(double progress) {
    if (progress < 0.3) return 'Waiting for other players...';
    if (progress < 0.7) return 'Almost there!';
    if (progress < 1.0) return 'Just one more player!';
    return 'All players finished!';
  }
}

class _ProgressiveResultsBody extends StatelessWidget {
  final List<PlayerResult> results;
  final int finishedPlayers;
  final int totalPlayers;
  final bool allPlayersFinished;
  final int userRank;
  final String roomId;

  const _ProgressiveResultsBody({
    required this.results,
    required this.finishedPlayers,
    required this.totalPlayers,
    required this.allPlayersFinished,
    required this.userRank,
    required this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserResult = results.firstWhere(
      (r) => r.isCurrentUser,
      orElse: () => results.first,
    );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade50,
            Colors.white,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header with user's rank highlight
            _buildUserRankCard(context, currentUserResult),
            const SizedBox(height: 20),
            
            // Progress header
            _buildProgressHeader(context),
            const SizedBox(height: 20),
            
            // Results list
            Expanded(
              child: _buildResultsList(context),
            ),
            
            // Action buttons when all finished
            if (allPlayersFinished) 
              _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserRankCard(BuildContext context, PlayerResult userResult) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _getRankColor(userResult.rank).withOpacity(0.8),
              _getRankColor(userResult.rank).withOpacity(0.4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Rank badge
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '#${userResult.rank}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _getRankColor(userResult.rank),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Rank',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userResult.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${userResult.correctAnswers}/${userResult.totalQuestions} correct • ${userResult.score} points',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            // Trophy icon
            Icon(
              _getTrophyIcon(userResult.rank),
              color: Colors.white,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressHeader(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Game Progress',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: allPlayersFinished ? Colors.green : Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    allPlayersFinished ? 'Complete! 🎉' : '$finishedPlayers/$totalPlayers',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: finishedPlayers / totalPlayers,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(
                allPlayersFinished ? Colors.green : Colors.blue,
              ),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$finishedPlayers players finished',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  allPlayersFinished ? 'All players completed!' : 'Waiting for ${totalPlayers - finishedPlayers}',
                  style: TextStyle(
                    color: allPlayersFinished ? Colors.green : Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.leaderboard, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Leaderboard',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '$finishedPlayers/$totalPlayers finished',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: results.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final result = results[index];
                  return _PlayerResultTile(
                    result: result,
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Game Complete!',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showLeaveConfirmationDialog(context);
                      },
                      icon: const Icon(Icons.exit_to_app),
                      label: const Text('Leave Room'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showPlayAgainDialog(context);
                      },
                      icon: const Icon(Icons.replay),
                      label: const Text('Play Again'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLeaveConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave Room?'),
        content: const Text('Are you sure you want to leave this room?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<RoomCubit>().leaveRoom(roomId: roomId);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }

  void _showPlayAgainDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Play Again?'),
        content: const Text('Start a new game with the same players?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Not Now'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement play again logic
              // context.read<RoomCubit>().resetAndStartNewGame(roomId);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Play again feature coming soon!')),
              );
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  IconData _getTrophyIcon(int rank) {
    if (rank == 1) return Icons.emoji_events;
    if (rank == 2) return Icons.workspace_premium;
    if (rank == 3) return Icons.military_tech;
    return Icons.star;
  }

  Color _getRankColor(int rank) {
    if (rank == 1) return const Color(0xFFFFD700); // Gold
    if (rank == 2) return const Color(0xFFC0C0C0); // Silver
    if (rank == 3) return const Color(0xFFCD7F32); // Bronze
    return Colors.blue;
  }
}

class _PlayerResultTile extends StatelessWidget {
  final PlayerResult result;
  final int index;

  const _PlayerResultTile({
    required this.result,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: result.isCurrentUser ? Colors.blue.shade50 : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: result.isCurrentUser 
            ? Border.all(color: Colors.blue.shade200) 
            : null,
      ),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _getRankColor(result.rank),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: result.finishedQuiz
                ? Text(
                    '${result.rank}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  )
                : const Icon(
                    Icons.timer,
                    color: Colors.white,
                    size: 16,
                  ),
          ),
        ),
        title: Row(
          children: [
            Text(
              result.username,
              style: TextStyle(
                fontWeight: result.isCurrentUser ? FontWeight.bold : FontWeight.normal,
                color: result.isCurrentUser ? Colors.blue.shade800 : Colors.black,
              ),
            ),
            if (result.isCurrentUser) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'YOU',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          '${result.correctAnswers}/${result.totalQuestions} correct • ${result.score} pts',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (result.finishedQuiz) ...[
              const Icon(Icons.flag, color: Colors.green, size: 20),
              const SizedBox(width: 4),
              Text(
                'Finished',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ] else ...[
              const Icon(Icons.play_arrow, color: Colors.orange, size: 20),
              const SizedBox(width: 4),
              Text(
                'Playing',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    if (rank == 1) return const Color(0xFFFFD700); // Gold
    if (rank == 2) return const Color(0xFFC0C0C0); // Silver
    if (rank == 3) return const Color(0xFFCD7F32); // Bronze
    return Colors.blue.shade400;
  }
}