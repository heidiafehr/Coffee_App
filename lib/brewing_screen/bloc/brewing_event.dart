part of 'brewing_bloc.dart';

abstract class BrewingEvent{}

class LoadCoffeeImage extends BrewingEvent {}

class AddCoffeeImageToFavorites extends BrewingEvent {
  final String imageUrl;

  AddCoffeeImageToFavorites(this.imageUrl);
}

