import 'package:coffee_app/random_coffee_image_repo/rest_instance_call.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service_locator.dart';
import 'coffee_image_class.dart';

class RandomCoffeeImageRepo {
  final coffeeImage = RestInstCall();

  RandomCoffeeImageRepo._internal();

  static final RandomCoffeeImageRepo _singleton = RandomCoffeeImageRepo._internal();

  factory RandomCoffeeImageRepo() {
    return _singleton;
  }

  Future<CoffeeImage> fetchCoffeeImage() async {
    return coffeeImage.fetchCoffeeImage();
  }

  Future<List<String>> fetchFavoritedImageCatalog() async {
    final SharedPreferences prefs = getIt<SharedPreferences>();
    try {
      List<String>? favoriteImageCatalog = prefs.getStringList('favoriteImageUrls');

      if (favoriteImageCatalog != null && favoriteImageCatalog.isNotEmpty) {
        return favoriteImageCatalog;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to get favorited images');
    }
  }
}