import 'package:get_it/get_it.dart';
import 'package:znoona_game_app/core/app/app_cubit/app_cubit.dart';

final GetIt sl = GetIt.instance;


Future<void> setupInjector() async {
 await _initCore();
}

Future<void> _initCore() async{
  sl.registerFactory(AppCubit.new);
}
