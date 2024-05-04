import 'package:coffee_app/favorited_coffee_screen/bloc/favorited_bloc.dart';
import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'brewing_screen/bloc/brewing_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() async {
  getIt.registerSingleton<RandomCoffeeImageRepo>(RandomCoffeeImageRepo());
  getIt.registerSingleton<BrewingBloc>(BrewingBloc());
  getIt.registerSingleton<FavoritedBloc>(FavoritedBloc());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton(prefs);
}
