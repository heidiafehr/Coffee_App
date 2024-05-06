part of 'favorited_bloc.dart';

class FavoritedState {}

class FavoritedImagesLoading extends FavoritedState {}

class FavoritedImagesLoaded extends FavoritedState {

  FavoritedImagesLoaded(this.favoritedImageCatalog);
  final List<String> favoritedImageCatalog;
}

class EmptyFavoritedImagesLoaded extends FavoritedState {}

class LoadFavoritedImagesError extends FavoritedState {

  LoadFavoritedImagesError(this.errorMessage);
  final String errorMessage;
}

class UnfavoritedImageSuccess extends FavoritedState {

  UnfavoritedImageSuccess(this.imageUrl);
  final String imageUrl;
}

class UnfavoritedImageError extends FavoritedState {

  UnfavoritedImageError(this.errorMessage);
  final String errorMessage;
}
