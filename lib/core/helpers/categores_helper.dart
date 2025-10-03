import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';

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
      return AppImages.random;
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
    //todo: handel language arabic & english
    case 'science':
      return 'about physics, chemistry, and biology';
    case 'football':
      return 'about players, teams, and tournaments';
    case 'food':
      return 'about meals, recipes, and world cuisines';
    case 'history':
      return 'about important historical events';
    case 'geography':
      return 'about countries, cities, and landmarks';
    case 'movies':
      return 'about films, actors, and directors';
    case 'technology':
      return 'about devices, gadgets, and innovations';
    default:
      return 'about computers, software, and innovations';
  }
}
