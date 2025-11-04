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
