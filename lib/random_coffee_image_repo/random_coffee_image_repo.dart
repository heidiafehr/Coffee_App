import 'package:coffee_app/random_coffee_image_repo/coffee_image_class.dart';
import 'package:coffee_app/random_coffee_image_repo/rest_instance_call.dart';
import 'package:coffee_app/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RandomCoffeeImageRepo {

  factory RandomCoffeeImageRepo() {
    return _singleton;
  }

  RandomCoffeeImageRepo._internal();
  final coffeeImage = RestInstCall();

  static final RandomCoffeeImageRepo _singleton =
      RandomCoffeeImageRepo._internal();

  Future<CoffeeImage> fetchCoffeeImage() async {
    return coffeeImage.fetchCoffeeImage();
  }

  Future<List<String>> fetchFavoritedImageCatalog() async {
    final prefs = getIt<SharedPreferences>();
    try {
      final favoriteImageCatalog =
          prefs.getStringList('favoriteImageUrls');

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
    final prefs = getIt<SharedPreferences>();

    final favoriteImageCatalog = await fetchFavoritedImageCatalog();

    try {
      if (!favoriteImageCatalog.contains(imageUrl)) {
        favoriteImageCatalog.add(imageUrl);
        await prefs.setStringList('favoriteImageUrls', favoriteImageCatalog);
      }
    } catch (e) {
      throw Exception('Failure to Add Image to Favorites: $e}');
    }
  }

  Future<void> removeFavoritedImage(String imageUrl) async {
    final prefs = getIt<SharedPreferences>();

    final favoriteImageCatalog = await fetchFavoritedImageCatalog();

    if (favoriteImageCatalog.isEmpty) {
      throw Exception('Empty favorited list');
    }

    if (!favoriteImageCatalog.contains(imageUrl)) {
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
