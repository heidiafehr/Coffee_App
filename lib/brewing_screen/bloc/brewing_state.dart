part of 'brewing_bloc.dart';

abstract class BrewingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BrewingLoading extends BrewingState {}

class BrewingLoaded extends BrewingState {
  BrewingLoaded(this.imageUrl, {this.isFavorited = false});

  final String imageUrl;
  final bool isFavorited;

  @override
  List<Object?> get props => [imageUrl, isFavorited];
}

class BrewingError extends BrewingState {
  BrewingError(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

class CoffeeFavoriteAdded extends BrewingState {}
