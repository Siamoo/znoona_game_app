import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';

// Keep your existing functions and add new ones for the hierarchy

String getCategoryImageForType(String type, String name) {
  switch (type) {
    case 'main_type':
      return _getMainTypeImage(name);
    case 'faculty':
      return _getFacultyImage(name);
    case 'year':
      return AppImages.history;
    case 'subject':
      return AppImages.history;
    case 'unit':
      return AppImages.history;
    case 'lesson':
      return AppImages.history;
    default:
      return AppImages.science;
  }
}

String _getMainTypeImage(String name) {
  switch (name.toLowerCase()) {
    case 'public':
      return AppImages.history;
    case 'university':
      return AppImages.history;
    case 'secondary':
      return AppImages.history;
    case 'preparatory':
      return AppImages.history;
    case 'primary':
      return AppImages.history;
    default:
      return AppImages.science;
  }
}

String _getFacultyImage(String name) {
  if (name.toLowerCase().contains('هندسة')) return AppImages.history;
  if (name.toLowerCase().contains('حاسبات')) return AppImages.history;
  if (name.toLowerCase().contains('طب')) return AppImages.history;
  if (name.toLowerCase().contains('علوم')) return AppImages.science;
  if (name.toLowerCase().contains('آداب')) return AppImages.history;
  return AppImages.history;
}

// Your existing functions for the old categories system
String getCategoryImages(String name) {
  switch (name.toLowerCase()) {
    case 'science':
      return AppImages.science;
    case 'football':
      return AppImages.football;
    case 'food':
      return AppImages.food;
    case 'history':
      return AppImages.history;
    case 'geography':
      return AppImages.geography;
    case 'movies':
      return AppImages.movies;
    case 'technology':
      return AppImages.technology;
    default:
      return AppImages.science;
  }
}

String getCategoryLangKeys(String name) {
  switch (name.toLowerCase()) {
    case 'science':
      return LangKeys.science;
    case 'football':
      return LangKeys.football;
    case 'food':
      return LangKeys.food;
    case 'history':
      return LangKeys.history;
    case 'geography':
      return LangKeys.geography;
    case 'movies':
      return LangKeys.movies;
    case 'technology':
      return LangKeys.technology;
    default:
      return LangKeys.random;
  }
}

String getCategoryDiscription(String name) {
  switch (name.toLowerCase()) {
    case 'science':
      return LangKeys.scienceDiscription;
    case 'football':
      return LangKeys.footballDiscription;
    case 'food':
      return LangKeys.foodDiscription;
    case 'history':
      return LangKeys.historyDiscription;
    case 'geography':
      return LangKeys.geographyDiscription;
    case 'movies':
      return LangKeys.moviesDiscription;
    case 'technology':
      return LangKeys.technologyDiscription;
    default:
      return LangKeys.randomDiscription;
  }
}