part of 'brewing_bloc.dart';

class BrewingState {}

class BrewingLoading extends BrewingState {}

class BrewingLoaded extends BrewingState {

  BrewingLoaded(this.imageUrl);
  final String imageUrl;
}

class BrewingError extends BrewingState {

  BrewingError(this.errorMessage);
  final String errorMessage;
}

class CoffeeFavoriteAdded extends BrewingState {}
