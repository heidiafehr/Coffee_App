import 'package:coffee_app/brewing_screen/bloc/brewing_bloc.dart';
import 'package:coffee_app/favorited_coffee_screen/bloc/favorited_bloc.dart';
import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt..registerSingleton<RandomCoffeeImageRepo>(RandomCoffeeImageRepo())
  ..registerSingleton<BrewingBloc>(BrewingBloc())
  ..registerSingleton<FavoritedBloc>(FavoritedBloc());

  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton(prefs);
}
