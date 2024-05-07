import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_app/brewing_screen/bloc/brewing_bloc.dart';
import 'package:coffee_app/random_coffee_image_repo/coffee_image_class.dart';
import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';
import 'package:coffee_app/random_coffee_image_repo/rest_instance_call.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

void main() {
  late CoffeeApi coffeeApi;
  late RandomCoffeeImageRepo randomCoffeeImageRepo;

  setUp(() {
    coffeeApi = MockCoffeeApi();
    randomCoffeeImageRepo = MockRandomCoffeeImageRepo();

    GetIt.instance
      ..registerSingleton<CoffeeApi>(coffeeApi)
      ..registerSingleton<RandomCoffeeImageRepo>(
        randomCoffeeImageRepo,
      );
  });

  tearDown(() {
    GetIt.instance
      ..unregister<CoffeeApi>()
      ..unregister<RandomCoffeeImageRepo>();
  });

  group('Brewing Bloc Test Init', () {
    test('Initial State is Loading', () async {
      final brewingBloc = BrewingBloc();

      await pumpEventQueue();
      expect(brewingBloc.state, isA<BrewingLoading>());
    });
  });

  group('Load Coffee Image states', () {
    blocTest<BrewingBloc, BrewingState>(
      'If image is NOT in favorites, show that image',
      setUp: () {
        when(() => coffeeApi.fetchCoffeeImage()).thenAnswer(
          (_) => Future.value(
            CoffeeImage(file: 'test_image_url'),
          ),
        );
        when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
            .thenAnswer((_) => Future.value([]));
      },
      act: (bloc) {
        bloc.add(LoadCoffeeImage());
      },
      build: BrewingBloc.new,
      expect: () => [
        isA<BrewingLoaded>().having(
          (state) => state.imageUrl,
          'Image url should be coffee image url',
          'test_image_url',
        ),
      ],
    );

    blocTest<BrewingBloc, BrewingState>(
      'If image is NOT in favorites, show that image',
      setUp: () {
        when(() => coffeeApi.fetchCoffeeImage()).thenAnswer(
          (_) => Future.value(
            CoffeeImage(file: 'test_image_url'),
          ),
        );
        when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
            .thenAnswer((_) => Future.value(['test_image_url']));
      },
      act: (bloc) {
        bloc.add(LoadCoffeeImage());
      },
      verify: (_) {
        verify(() => coffeeApi.fetchCoffeeImage()).called(4);
        verify(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
            .called(4);
      },
      build: BrewingBloc.new,
      expect: () => [
        isA<BrewingLoaded>().having(
          (state) => state.imageUrl,
          'Image url should be coffee image url after 3 tries',
          'test_image_url',
        ),
      ],
    );

    blocTest<BrewingBloc, BrewingState>(
      'If image api fails, show error state',
      setUp: () {
        when(() => coffeeApi.fetchCoffeeImage()).thenThrow(Error());
        when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
            .thenThrow(
          Error(),
        );
      },
      act: (bloc) {
        bloc.add(LoadCoffeeImage());
      },
      build: BrewingBloc.new,
      expect: () => [
        isA<BrewingError>(),
      ],
    );
  });
  group('Coffee image favorites is updated', () {
    blocTest<BrewingBloc, BrewingState>(
      'Adds to favorites when event is a favorited one',
      setUp: () {
        when(() => randomCoffeeImageRepo.addFavoritedImage('test_image_url'))
            .thenAnswer((_) => Future.value());
      },
      act: (bloc) {
        bloc.add(
          UpdateCoffeeImageToFavorites(
            'test_image_url',
            isFavorited: true,
          ),
        );
      },
      verify: (_) {
        verify(() => randomCoffeeImageRepo.addFavoritedImage('test_image_url'))
            .called(1);
      },
      build: BrewingBloc.new,
      expect: () => [
        isA<BrewingLoaded>(),
      ],
    );

    blocTest<BrewingBloc, BrewingState>(
      'Removes from favorites when event is NOT a favorited one',
      setUp: () {
        when(() => randomCoffeeImageRepo.removeFavoritedImage('test_image_url'))
            .thenAnswer((_) => Future.value());
      },
      act: (bloc) {
        bloc.add(
          UpdateCoffeeImageToFavorites(
            'test_image_url',
            isFavorited: false,
          ),
        );
      },
      verify: (_) {
        verify(() =>
                randomCoffeeImageRepo.removeFavoritedImage('test_image_url'),)
            .called(1);
      },
      build: BrewingBloc.new,
      expect: () => [
        isA<BrewingLoaded>(),
      ],
    );
    blocTest<BrewingBloc, BrewingState>(
      'Emits error state when API fails',
      setUp: () {
        when(() => randomCoffeeImageRepo.addFavoritedImage('test_image_url'))
            .thenThrow(Error());
      },
      act: (bloc) {
        bloc.add(
          UpdateCoffeeImageToFavorites(
            'test_image_url',
            isFavorited: true,
          ),
        );
      },
      build: BrewingBloc.new,
      expect: () => [
        isA<BrewingLoaded>(),
        isA<BrewingError>(),
      ],
    );
  });
}
