import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_app/favorited_coffee_screen/bloc/favorited_bloc.dart';
import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

void main() {
  late RandomCoffeeImageRepo randomCoffeeImageRepo;

  setUp(() {
    randomCoffeeImageRepo = MockRandomCoffeeImageRepo();

    GetIt.instance.registerSingleton<RandomCoffeeImageRepo>(
      randomCoffeeImageRepo,
    );
  });

  tearDown(() {
    GetIt.instance.unregister<RandomCoffeeImageRepo>();
  });

  group('Testing initial state', () {
    test('Initial state', () async {
      final bloc = FavoritedBloc();

      await pumpEventQueue();
      expect(bloc.state, isA<FavoritedImagesLoading>());
    });
  });

  group('Loading favorited images', () {
    blocTest<FavoritedBloc, FavoritedState>(
      'On load success',
      setUp: () {
        when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
            .thenAnswer((_) => Future.value(['test_image_url']));
      },
      build: FavoritedBloc.new,
      act: (bloc) {
        bloc.add(LoadFavoritedImages());
      },
      expect: () => [
        isA<FavoritedImagesLoaded>().having(
          (state) => state.favoritedImageCatalog,
          'Image catalog is correct',
          ['test_image_url'],
        ),
      ],
    );
    blocTest<FavoritedBloc, FavoritedState>(
      'On load failure',
      setUp: () {
        when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
            .thenThrow(Error());
      },
      build: FavoritedBloc.new,
      act: (bloc) {
        bloc.add(LoadFavoritedImages());
      },
      expect: () => [
        isA<LoadFavoritedImagesError>(),
      ],
    );
  });

  group('Unfavoriting images', () {
    blocTest<FavoritedBloc, FavoritedState>(
      'Success state',
      setUp: () {
        when(
          () => randomCoffeeImageRepo.removeFavoritedImage(
            'second_test_image_url',
          ),
        ).thenAnswer((_) => Future.value());
        when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
            .thenAnswer((_) => Future.value(['test_image_url']));
      },
      act: (bloc) {
        bloc.add(UnfavoriteImage('second_test_image_url'));
      },
      build: FavoritedBloc.new,
      expect: () => [
        isA<FavoritedImagesLoaded>().having(
          (state) => state.favoritedImageCatalog,
          'Catalog is correct',
          ['test_image_url'],
        ),
      ],
    );
    blocTest<FavoritedBloc, FavoritedState>(
      'Failure state',
      setUp: () {
        when(
          () => randomCoffeeImageRepo
              .removeFavoritedImage('second_test_image_url'),
        ).thenThrow(Error());
        when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
            .thenThrow(Error());
      },
      act: (bloc) {
        bloc.add(UnfavoriteImage('second_test_image_url'));
      },
      build: FavoritedBloc.new,
      expect: () => [
        isA<LoadFavoritedImagesError>(),
      ],
    );
  });
}
