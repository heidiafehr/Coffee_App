part of 'brewing_bloc.dart';

abstract class BrewingEvent {}

class LoadCoffeeImage extends BrewingEvent {}

class UpdateCoffeeImageToFavorites extends BrewingEvent {
  UpdateCoffeeImageToFavorites(this.imageUrl, {required this.isFavorited});

  final String imageUrl;
  final bool isFavorited;
}
