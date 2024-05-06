part of 'favorited_bloc.dart';

abstract class FavoritedEvent {}

class LoadFavoritedImages extends FavoritedEvent {}

class UnfavoriteImage extends FavoritedEvent {

  UnfavoriteImage(this.imageUrl);
  final String imageUrl;
}
