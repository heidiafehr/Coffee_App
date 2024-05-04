import 'package:coffee_app/random_coffee_image_repo/rest_instance_call.dart';

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

}