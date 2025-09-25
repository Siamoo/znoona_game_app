import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/core/service/shared_pref/pref_keys.dart';
import 'package:znoona_game_app/core/service/shared_pref/shared_pref.dart';

part 'app_state.dart';
part 'app_cubit.freezed.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState.initial());

  bool isDarkMode = true;
  Future<void> changeAppThemeMode({bool? sheredMode}) async {
    if (sheredMode != null) {
      isDarkMode = sheredMode;
      emit(AppState.themeChangMode(isDarkMode: sheredMode));
    } else {
      isDarkMode = !isDarkMode;
      await SharedPref().setBoolean(PrefKeys.themeMode, isDarkMode).then(
        (value) {
          emit(AppState.themeChangMode(isDarkMode: isDarkMode));
        },
      );
      ;
    }
  }

}
