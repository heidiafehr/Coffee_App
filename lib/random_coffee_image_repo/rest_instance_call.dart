import 'dart:convert';

import 'package:coffee_app/random_coffee_image_repo/coffee_image_class.dart';
import 'package:http/http.dart' as http;

class CoffeeApi {
  Future<CoffeeImage> fetchCoffeeImage() async {
    try {
      final response = await http
          .get(Uri.parse('https://coffee.alexflipnote.dev/random.json'));

      if (response.statusCode == 200) {
        return CoffeeImage.fromRestJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      } else {
        throw Exception('Failed to retrieve coffee image');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
