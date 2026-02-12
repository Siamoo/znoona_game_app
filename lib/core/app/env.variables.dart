import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvTypeEnum { dev, prod }

class EnvVariables {
  EnvVariables._();
  static final EnvVariables instance = EnvVariables._();

  String _envType = '';

  Future<void> init({required EnvTypeEnum envType}) async {
    switch (envType) {
      case EnvTypeEnum.dev:
        await dotenv.load(fileName: '.env.dev');
      case EnvTypeEnum.prod:
        await dotenv.load(fileName: '.env.prod');
    }
    _envType = dotenv.env['ENV_TYPE'] ?? 'dev';
  }

  bool get debugMode => _envType == 'dev';

  String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  String get phoneNumber => dotenv.env['PHONE_NUMBER'] ?? '';
  String get contactEmail => dotenv.env['CONTACT_EMAIL'] ?? '';
  String get facebookLink => dotenv.env['FACEBOOK_LINK'] ?? '';
}
