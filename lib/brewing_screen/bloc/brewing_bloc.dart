import 'package:bloc/bloc.dart';
import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';
import 'package:coffee_app/random_coffee_image_repo/rest_instance_call.dart';
import 'package:coffee_app/service_locator.dart';
import 'package:equatable/equatable.dart';

part 'brewing_event.dart';

part 'brewing_state.dart';

class BrewingBloc extends Bloc<BrewingEvent, BrewingState> {
  BrewingBloc() : super(BrewingLoading()) {
    on<LoadCoffeeImage>(_fetchImage);
    on<UpdateCoffeeImageToFavorites>(_addCoffeeImageToFavorites);
  }

  CoffeeApi api = getIt<CoffeeApi>();
  RandomCoffeeImageRepo imageRepo = getIt<RandomCoffeeImageRepo>();

  Future<void> _fetchImage(
    LoadCoffeeImage event,
    Emitter<BrewingState> emit, {
    int tries = 0,
  }) async {
    try {
      final image = await api.fetchCoffeeImage();
      final favoriteImageUrls = await imageRepo.fetchFavoritedImageCatalog();
      final imageUrl = image.file;

      //check to make sure fetched URL is not in favorites
      if (!favoriteImageUrls.contains(imageUrl)) {
        emit(BrewingLoaded(imageUrl));
      } else {
        if (tries < 3) {
          // refetching to grab new image that is NOT already added to favorites
          await _fetchImage(event, emit, tries: tries + 1);
        } else {
          // Try 3 times to give the user a new image.
          // If, after 3 tries it is STILl a favorited image, show that image
          // to avoid a stall in user experience.
          emit(BrewingLoaded(imageUrl));
        }
      }
    } catch (e) {
      emit(BrewingError(e.toString()));
    }
  }

  Future<void> _addCoffeeImageToFavorites(
    UpdateCoffeeImageToFavorites event,
    Emitter<BrewingState> emit,
  ) async {
    emit(BrewingLoaded(event.imageUrl, isFavorited: event.isFavorited));
    try {
      if (event.isFavorited) {
        await imageRepo.addFavoritedImage(event.imageUrl);
      } else {
        await imageRepo.removeFavoritedImage(event.imageUrl);
      }
    } catch (e) {
      emit(BrewingError('Failure to Add Image to Favorites: $e}'));
    }
  }
}
