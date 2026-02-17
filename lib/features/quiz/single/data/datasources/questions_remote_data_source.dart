import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medaan_almaarifa/features/quiz/single/data/models/question_model.dart';

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
          'p_limit_count': 15, // matches SQL parameter
        },
      );

      // DEBUG: Print the response to check if image exists

      // Map the result to QuestionModel
      final data = response.map((e) {
        // DEBUG: Print each item's image field
        final json = e as Map<String, dynamic>;

        return QuestionModel.fromJson(json);
      }).toList();

      return data;
    } catch (e) {
      // Optional: handle errors gracefully

      return [];
    }
  }
}
