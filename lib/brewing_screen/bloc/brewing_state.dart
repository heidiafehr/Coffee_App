part of 'brewing_bloc.dart';

class BrewingState {}

class BrewingLoading extends BrewingState {}

class BrewingLoaded extends BrewingState {
  final String imageUrl;

  BrewingLoaded(this.imageUrl);
}

class BrewingError extends BrewingState {
  final String errorMessage;

  BrewingError(this.errorMessage);
}

class CoffeeFavoriteAdded extends BrewingState {}
