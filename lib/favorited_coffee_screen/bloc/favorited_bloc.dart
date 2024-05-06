import 'package:bloc/bloc.dart';
import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';
import 'package:coffee_app/service_locator.dart';

part 'favorited_event.dart';

part 'favorited_state.dart';

class FavoritedBloc extends Bloc<FavoritedEvent, FavoritedState> {

  FavoritedBloc() : super(FavoritedImagesLoading()) {
    on<LoadFavoritedImages>(_fetchFavoriteImages);
    on<UnfavoriteImage>(_unfavoriteImage);
  }
  RandomCoffeeImageRepo api = getIt<RandomCoffeeImageRepo>();

  Future<void> _fetchFavoriteImages(
      LoadFavoritedImages event, Emitter<FavoritedState> emit,) async {
    emit(FavoritedImagesLoading());

    try {
      final favoritedImageCatalog =
          await api.fetchFavoritedImageCatalog();
      if (favoritedImageCatalog.isEmpty) {
        emit(EmptyFavoritedImagesLoaded());
      } else {
        emit(FavoritedImagesLoaded(favoritedImageCatalog));
      }
    } catch (e) {
      emit(LoadFavoritedImagesError(e.toString()));
    }
  }

  Future<void> _unfavoriteImage(
      UnfavoriteImage event, Emitter<FavoritedState> emit,) async {
    try {
      await api.removeFavoritedImage(event.imageUrl);
      final favoritedImageCatalog =
          await api.fetchFavoritedImageCatalog();

      if (favoritedImageCatalog.isEmpty) {
        emit(EmptyFavoritedImagesLoaded());
      } else {
        emit(UnfavoritedImageSuccess(event.imageUrl));
      }
    } catch (e) {
      emit(UnfavoritedImageError(e.toString()));
    }
  }
}
