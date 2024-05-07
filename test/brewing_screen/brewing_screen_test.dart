import 'package:coffee_app/brewing_screen/bloc/brewing_bloc.dart';
import 'package:coffee_app/brewing_screen/brewing_screen.dart';
import 'package:coffee_app/random_coffee_image_repo/coffee_image_class.dart';
import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';
import 'package:coffee_app/random_coffee_image_repo/rest_instance_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

void main() {
  late CoffeeApi coffeeApi;
  late RandomCoffeeImageRepo randomCoffeeImageRepo;

  final theme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
    ),
  );

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

  testGoldens('Showing image NOT in favorites', (tester) async {
    when(() => coffeeApi.fetchCoffeeImage()).thenAnswer(
      (_) => Future.value(
        CoffeeImage(file: 'test_image_url'),
      ),
    );
    when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
        .thenAnswer((_) => Future.value([]));
    final bloc = BrewingBloc();

    final widget = MaterialApp(
      theme: theme,
      home: BlocProvider(
        create: (_) => bloc,
        child: const BrewingScreen(),
      ),
    );
    bloc.add(LoadCoffeeImage());

    // await pumpEventQueue();
    await tester.pumpWidgetBuilder(widget);
    await multiScreenGolden(tester, 'showing_image_not_in_favorites');
  });

  testGoldens('Showing image IN favorites', (tester) async {
    when(() => coffeeApi.fetchCoffeeImage()).thenAnswer(
      (_) => Future.value(
        CoffeeImage(file: 'test_image_url'),
      ),
    );
    when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
        .thenAnswer((_) => Future.value(['test_image_url']));
    when(() => randomCoffeeImageRepo.addFavoritedImage('test_image_url'))
        .thenAnswer((_) => Future.value());
    final bloc = BrewingBloc();

    final widget = MaterialApp(
      theme: theme,
      home: BlocProvider(
        create: (_) => bloc,
        child: const BrewingScreen(),
      ),
    );
    bloc.add(LoadCoffeeImage());

    await tester.pumpWidgetBuilder(widget);

    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pumpAndSettle();

    await multiScreenGolden(tester, 'showing_image_in_favorites');
  });

  testGoldens('Error Loading', (tester) async {
    when(() => coffeeApi.fetchCoffeeImage())
        .thenThrow(Exception('401 - Please try again'));
    when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
        .thenThrow(Exception('401 - Please try again'));
    when(() => randomCoffeeImageRepo.addFavoritedImage('test_image_url'))
        .thenThrow(Exception('401 - Please try again'));
    final bloc = BrewingBloc();

    final widget = MaterialApp(
      theme: theme,
      home: BlocProvider(
        create: (_) => bloc,
        child: const BrewingScreen(),
      ),
    );
    bloc.add(LoadCoffeeImage());
    await tester.pumpWidgetBuilder(widget);

    await multiScreenGolden(tester, 'showing_image_error_loading');
  });
}
