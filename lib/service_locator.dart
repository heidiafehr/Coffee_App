import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';
import 'package:get_it/get_it.dart';

import 'brewing_screen/bloc/brewing_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() async {
  getIt.registerSingleton<RandomCoffeeImageRepo>(RandomCoffeeImageRepo());
  getIt.registerSingleton<BrewingBloc>(BrewingBloc());
}
