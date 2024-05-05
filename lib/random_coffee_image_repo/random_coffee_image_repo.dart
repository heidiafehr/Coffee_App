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

  Future<void> addFavoritedImage(String imageUrl) async {
    final SharedPreferences prefs = getIt<SharedPreferences>();

    List<String> favoriteImageCatalog = await fetchFavoritedImageCatalog();

    try {
      if(!favoriteImageCatalog.contains(imageUrl)) {
        favoriteImageCatalog.add(imageUrl);
        await prefs.setStringList('favoriteImageUrls', favoriteImageCatalog);
      }
    } catch(e) {
      throw Exception('Failure to Add Image to Favorites: $e}');
    }
  }

  Future<void> removeFavoritedImage(String imageUrl) async {
    final SharedPreferences prefs = getIt<SharedPreferences>();

    List<String> favoriteImageCatalog = await fetchFavoritedImageCatalog();

    if(favoriteImageCatalog.isEmpty) {
      throw Exception('Empty favorited list');
    }

    if(!favoriteImageCatalog.contains(imageUrl)) {
      throw Exception('Image not found in favorited list');
    }

    try {
      favoriteImageCatalog.remove(imageUrl);
      await prefs.setStringList('favoriteImageUrls', favoriteImageCatalog);
    } catch (e) {
      throw Exception('Error removing image from favorites: $e');
    }
  }
}