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

class UnfavoritedImageSuccess extends FavoritedState {
  final String imageUrl;

  UnfavoritedImageSuccess(this.imageUrl);
}

class UnfavoritedImageError extends FavoritedState {
  final String errorMessage;

  UnfavoritedImageError(this.errorMessage);
}