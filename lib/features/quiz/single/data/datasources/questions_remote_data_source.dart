import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/features/quiz/single/data/models/question_model.dart';

abstract class QuestionsRemoteDataSource {
  Future<List<QuestionModel>> getQuestionsByCategory(String categoryId);
}

class QuestionsRemoteDataSourceImpl implements QuestionsRemoteDataSource {
  QuestionsRemoteDataSourceImpl(this.client);
  final SupabaseClient client;

  @override
  Future<List<QuestionModel>> getQuestionsByCategory(String categoryId) async {
    try {
      // Call the PostgreSQL RPC function
      final response = await client.rpc<List<dynamic>>(
        'get_random_questions',
        params: {
          'p_category_id': categoryId, // matches SQL parameter
          'p_limit_count': 15,         // matches SQL parameter
        },
      );

      // Map the result to QuestionModel
      final data = response
          .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return data;
    } catch (e) {
      // Optional: handle errors gracefully
      print('Error fetching questions: $e');
      return [];
    }
  }
}
