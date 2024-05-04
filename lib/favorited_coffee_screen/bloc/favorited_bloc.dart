import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';

part 'favorited_event.dart';

part 'favorited_state.dart';

class FavoritedBloc extends Bloc<FavoritedEvent, FavoritedState> {
  FavoritedBloc() : super(FavoritedImagesLoading()){
    on<LoadFavoritedImages>(_fetchFavoriteImages);
  }

  Future<void> _fetchFavoriteImages(LoadFavoritedImages event, Emitter<FavoritedState> emit) async {
    RandomCoffeeImageRepo api = getIt<RandomCoffeeImageRepo>();
    emit(FavoritedImagesLoading());

    try{
      final favoritedImageCatalog = await api.fetchFavoritedImageCatalog();

      if(favoritedImageCatalog.isEmpty) {
        emit(EmptyFavoritedImagesLoaded());
      }
      emit(FavoritedImagesLoaded(favoritedImageCatalog));
    } catch (e) {
      emit(LoadFavoritedImagesError(e.toString()));
    }
  }
}