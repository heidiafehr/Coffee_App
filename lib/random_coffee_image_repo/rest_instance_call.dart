import 'dart:convert';

import 'coffee_image_class.dart';
import 'package:http/http.dart' as http;


class RestInstCall {
  Future<CoffeeImage> fetchCoffeeImage() async {
    final response = await http.get(
      Uri.parse('https://coffee.alexflipnote.dev/random.json')
    );

    if (response.statusCode == 200) {
      return CoffeeImage.fromRestJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to retrieve coffee image');
    }
  }
}