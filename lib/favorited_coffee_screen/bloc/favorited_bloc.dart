import 'package:bloc/bloc.dart';
import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';

import '../../service_locator.dart';

part 'favorited_event.dart';

part 'favorited_state.dart';

class FavoritedBloc extends Bloc<FavoritedEvent, FavoritedState> {
  RandomCoffeeImageRepo api = getIt<RandomCoffeeImageRepo>();

  FavoritedBloc() : super(FavoritedImagesLoading()) {
    on<LoadFavoritedImages>(_fetchFavoriteImages);
    on<UnfavoriteImage>(_unfavoriteImage);
  }

  Future<void> _fetchFavoriteImages(
      LoadFavoritedImages event, Emitter<FavoritedState> emit) async {
    emit(FavoritedImagesLoading());

    try {
      final favoritedImageCatalog = await api.fetchFavoritedImageCatalog();

      if (favoritedImageCatalog.isEmpty) {
        emit(EmptyFavoritedImagesLoaded());
      }
      emit(FavoritedImagesLoaded(favoritedImageCatalog));
    } catch (e) {
      emit(LoadFavoritedImagesError(e.toString()));
    }
  }

  Future<void> _unfavoriteImage(
      UnfavoriteImage event, Emitter<FavoritedState> emit) async {
    try {
      await api.removeFavoritedImage(event.imageUrl);

      emit(UnfavoritedImageSuccess(event.imageUrl));
    } catch (e) {
      emit(UnfavoritedImageError(e.toString()));
    }
  }
}
