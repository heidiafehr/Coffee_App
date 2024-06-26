import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';
import 'package:coffee_app/random_coffee_image_repo/rest_instance_call.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt
    ..registerSingleton<RandomCoffeeImageRepo>(RandomCoffeeImageRepo())
    ..registerSingleton<CoffeeApi>(CoffeeApi())
    ..registerSingletonAsync(SharedPreferences.getInstance);
}
