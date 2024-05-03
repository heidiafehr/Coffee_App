import 'package:bloc/bloc.dart';
import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';

import '../../service_locator.dart';

part 'brewing_event.dart';

part 'brewing_state.dart';

class BrewingBloc extends Bloc<BrewingEvent, BrewingState> {
  BrewingBloc() : super(BrewingLoading()){
    on<LoadCoffeeImage>(_fetchImage);
  }

  Future<void> _fetchImage(LoadCoffeeImage event, Emitter<BrewingState> emit) async {
    RandomCoffeeImageRepo api = getIt<RandomCoffeeImageRepo>();
    emit(BrewingLoading());
    try {
      final image = await api.fetchCoffeeImage();
      final imageUrl = image.file;

      emit(BrewingLoaded(imageUrl));
    } catch (e) {
      emit(BrewingError(e.toString()));
    }
  }
}
