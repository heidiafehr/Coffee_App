part of 'favorited_bloc.dart';

class FavoritedState {}

class FavoritedImagesLoading extends FavoritedState {}

class FavoritedImagesLoaded extends FavoritedState {
  final List<String> favoritedImageCatalog;

  FavoritedImagesLoaded(this.favoritedImageCatalog);
}

class EmptyFavoritedImagesLoaded extends FavoritedState {}

class LoadFavoritedImagesError extends FavoritedState {
  final String errorMessage;

  LoadFavoritedImagesError(this.errorMessage);
}