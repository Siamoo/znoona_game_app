import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvTypeEnum { dev, prod }

class EnvVariables {
  EnvVariables._();
  static final EnvVariables instance = EnvVariables._();

  String _envType = '';
  bool _isInitialized = false;

  Future<void> init({required EnvTypeEnum envType}) async {
    // Prevent multiple initializations
    if (_isInitialized) return;
    
    try {
      switch (envType) {
        case EnvTypeEnum.dev:
          await dotenv.load(fileName: '.env.dev');
        case EnvTypeEnum.prod:
          await dotenv.load(fileName: '.env.prod');
      }
      
      _envType = dotenv.env['ENV_TYPE'] ?? 
          (envType == EnvTypeEnum.dev ? 'dev' : 'prod');
      _isInitialized = true;
      
    } catch (e) {
      throw Exception('Failed to load environment variables: $e');
    }
  }

  bool get debugMode {
    if (!_isInitialized) {
      // Default to true if not initialized (safe for error screens)
      return true;
    }
    return _envType == 'dev';
  }

  String get supabaseUrl {
    if (!_isInitialized) return '';
    try {
      return dotenv.env['SUPABASE_URL'] ?? '';
    } catch (e) {
      return '';
    }
  }
  
  String get supabaseAnonKey {
    if (!_isInitialized) return '';
    try {
      return dotenv.env['SUPABASE_ANON_KEY'] ?? '';
    } catch (e) {
      return '';
    }
  }
  
  String get phoneNumber {
    if (!_isInitialized) return '';
    try {
      return dotenv.env['PHONE_NUMBER'] ?? '';
    } catch (e) {
      return '';
    }
  }
  
  String get contactEmail {
    if (!_isInitialized) return '';
    try {
      return dotenv.env['CONTACT_EMAIL'] ?? '';
    } catch (e) {
      return '';
    }
  }
  
  String get facebookLink {
    if (!_isInitialized) return '';
    try {
      return dotenv.env['FACEBOOK_LINK'] ?? '';
    } catch (e) {
      return '';
    }
  }

  // Helper method to check if initialization is complete
  bool get isInitialized => _isInitialized;
  
  // Helper method to reset (useful for testing)
  void reset() {
    _isInitialized = false;
    _envType = '';
  }
}