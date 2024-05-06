import 'package:bloc/bloc.dart';
import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';
import 'package:coffee_app/service_locator.dart';

part 'brewing_event.dart';
part 'brewing_state.dart';

class BrewingBloc extends Bloc<BrewingEvent, BrewingState> {

  BrewingBloc() : super(BrewingLoading()) {
    on<LoadCoffeeImage>(_fetchImage);
    on<AddCoffeeImageToFavorites>(_addCoffeeImageToFavorites);
  }
  RandomCoffeeImageRepo api = getIt<RandomCoffeeImageRepo>();

  Future<void> _fetchImage(
      LoadCoffeeImage event, Emitter<BrewingState> emit,) async {
    emit(BrewingLoading());
    try {
      final image = await api.fetchCoffeeImage();
      final favoriteImageUrls = await api.fetchFavoritedImageCatalog();
      final imageUrl = image.file;

      //check to make sure fetched URL is not in favorites
      if (!favoriteImageUrls.contains(imageUrl)) {
        emit(BrewingLoaded(imageUrl));
      } else {
        await _fetchImage(event, emit);
      }
    } catch (e) {
      emit(BrewingError(e.toString()));
    }
  }

  Future<void> _addCoffeeImageToFavorites(
      AddCoffeeImageToFavorites event, Emitter<BrewingState> emit,) async {
    try {
      await api.addFavoritedImage(event.imageUrl);
    } catch (e) {
      emit(BrewingError('Failure to Add Image to Favorites: $e}'));
    }
  }
}
