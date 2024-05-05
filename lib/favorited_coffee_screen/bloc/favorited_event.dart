part of 'favorited_bloc.dart';

abstract class FavoritedEvent {}

class LoadFavoritedImages extends FavoritedEvent {}

class UnfavoriteImage extends FavoritedEvent {
  final String imageUrl;

  UnfavoriteImage(this.imageUrl);
}

