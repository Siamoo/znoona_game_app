class PlayerResult {
  PlayerResult({
    required this.userId,
    required this.username,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.rank,
    required this.isCurrentUser,
    required this.finishedQuiz,
    this.finishedAt,
    this.avatarUrl, 
  });
  final String userId;
  final String username;
  final int score;
  final int correctAnswers;
  final int totalQuestions;
  final int rank;
  final bool isCurrentUser;
  final bool finishedQuiz;
  final DateTime? finishedAt;
  final String? avatarUrl; 

  @override
  String toString() {
    return 'PlayerResult{username: $username, score: $score, rank: $rank, finished: $finishedQuiz, avatar: $avatarUrl}';
  }
}