import 'package:bloc/bloc.dart';
import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';
import '../../service_locator.dart';

part 'brewing_event.dart';

part 'brewing_state.dart';

class BrewingBloc extends Bloc<BrewingEvent, BrewingState> {
  List<String> favoriteImageUrls = [];
  BrewingBloc() : super(BrewingLoading()){
    on<LoadCoffeeImage>(_fetchImage);
    on<AddCoffeeImageToFavorites>(_addCoffeeImageToFavorites);
  }

  Future<void> _fetchImage(LoadCoffeeImage event, Emitter<BrewingState> emit) async {
    RandomCoffeeImageRepo api = getIt<RandomCoffeeImageRepo>();
    emit(BrewingLoading());
    try {
      final image = await api.fetchCoffeeImage();
      final imageUrl = image.file;

      //check to make sure fetched URL is not in favorites
      if (!favoriteImageUrls.contains(imageUrl)) {
        emit(BrewingLoaded(imageUrl));
      } else {
        _fetchImage(event, emit);
      }
    } catch (e) {
      emit(BrewingError(e.toString()));
    }
  }

  Future<void> _addCoffeeImageToFavorites(AddCoffeeImageToFavorites event, Emitter<BrewingState> emit) async {
    try {
      favoriteImageUrls.add(event.imageUrl);
    } catch (e) {
      emit(BrewingError('Failure to Add Image to Favorites: $e}'));
    }
  }
}
