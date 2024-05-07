part of 'favorited_bloc.dart';

abstract class FavoritedState extends Equatable{
  @override
  List<Object?> get props => [];
}

class FavoritedImagesLoading extends FavoritedState {}

class FavoritedImagesLoaded extends FavoritedState {

  FavoritedImagesLoaded(this.favoritedImageCatalog);
  final List<String> favoritedImageCatalog;

  @override
  List<Object?> get props => [favoritedImageCatalog];
}

class LoadFavoritedImagesError extends FavoritedState {

  LoadFavoritedImagesError(this.errorMessage);
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
