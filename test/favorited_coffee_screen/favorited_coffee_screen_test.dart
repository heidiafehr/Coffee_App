import 'package:coffee_app/favorited_coffee_screen/bloc/favorited_bloc.dart';
import 'package:coffee_app/favorited_coffee_screen/favorited_coffee_screen.dart';
import 'package:coffee_app/random_coffee_image_repo/random_coffee_image_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

void main() {
  late RandomCoffeeImageRepo randomCoffeeImageRepo;

  final theme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
    ),
  );

  setUp(() {
    randomCoffeeImageRepo = MockRandomCoffeeImageRepo();

    GetIt.instance.registerSingleton<RandomCoffeeImageRepo>(
      randomCoffeeImageRepo,
    );
  });

  tearDown(() {
    GetIt.instance.unregister<RandomCoffeeImageRepo>();
  });

  testGoldens('Showing loaded favorites', (tester) async {
    when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog()).thenAnswer(
        (_) => Future.value(['test_image_url', 'another_test_image_url']),);
    final bloc = FavoritedBloc();

    final widget = MaterialApp(
      theme: theme,
      home: BlocProvider(
        create: (_) => bloc,
        child: const FavoritedCoffeeScreen(),
      ),
    );
    bloc.add(LoadFavoritedImages());

    // await pumpEventQueue();
    await tester.pumpWidgetBuilder(widget);
    await multiScreenGolden(tester, 'showing_loaded_favorites');
  });

  testWidgets('Loaded favorites appear', (widgetTester) async {
    when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog()).thenAnswer(
        (_) => Future.value(['test_image_url', 'another_test_image_url']),);
    final bloc = FavoritedBloc();

    final widget = MaterialApp(
      theme: theme,
      home: BlocProvider(
        create: (_) => bloc,
        child: const FavoritedCoffeeScreen(),
      ),
    );
    bloc.add(LoadFavoritedImages());

    // await pumpEventQueue();
    await widgetTester.pumpWidgetBuilder(widget);
    await widgetTester.pumpAndSettle();

    expect(find.byType(Placeholder), findsExactly(2));
  });

  testGoldens('Showing empty loaded favorites', (tester) async {
    when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
        .thenAnswer((_) => Future.value([]));
    final bloc = FavoritedBloc();

    final widget = MaterialApp(
      theme: theme,
      home: BlocProvider(
        create: (_) => bloc,
        child: const FavoritedCoffeeScreen(),
      ),
    );
    bloc.add(LoadFavoritedImages());

    // await pumpEventQueue();
    await tester.pumpWidgetBuilder(widget);
    await multiScreenGolden(tester, 'showing_empty_loaded_favorites');
  });

  testGoldens('Removing item from favorites', (tester) async {
    when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog()).thenAnswer(
        (_) => Future.value(['test_image_url', 'another_test_image_url']),);
    when(() => randomCoffeeImageRepo.removeFavoritedImage('test_image_url'))
        .thenAnswer((_) => Future.value());
    final bloc = FavoritedBloc();

    final widget = MaterialApp(
      theme: theme,
      home: BlocProvider(
        create: (_) => bloc,
        child: const FavoritedCoffeeScreen(),
      ),
    );
    bloc.add(LoadFavoritedImages());

    // await pumpEventQueue();
    await tester.pumpWidgetBuilder(widget);

    when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
        .thenAnswer((_) => Future.value(['another_test_image_url']));

    await tester.tap(find.byIcon(Icons.favorite).first);
    await tester.pumpAndSettle();

    await multiScreenGolden(tester, 'removing_item_from_favorites');
  });

  testWidgets('Removing favorited items', (widgetTester) async {
    when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog()).thenAnswer(
        (_) => Future.value(['test_image_url', 'another_test_image_url']),);
    when(() => randomCoffeeImageRepo.removeFavoritedImage('test_image_url'))
        .thenAnswer((_) => Future.value());
    final bloc = FavoritedBloc();

    final widget = MaterialApp(
      theme: theme,
      home: BlocProvider(
        create: (_) => bloc,
        child: const FavoritedCoffeeScreen(),
      ),
    );
    bloc.add(LoadFavoritedImages());

    // await pumpEventQueue();
    await widgetTester.pumpWidgetBuilder(widget);

    when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
        .thenAnswer((_) => Future.value(['another_test_image_url']));

    await widgetTester.tap(find.byIcon(Icons.favorite).first);
    await widgetTester.pumpAndSettle();
    expect(find.byType(Placeholder), findsExactly(1));
  });

  testGoldens('On error', (tester) async {
    when(() => randomCoffeeImageRepo.fetchFavoritedImageCatalog())
        .thenThrow(Exception('Something went wrong'));
    final bloc = FavoritedBloc();

    final widget = MaterialApp(
      theme: theme,
      home: BlocProvider(
        create: (_) => bloc,
        child: const FavoritedCoffeeScreen(),
      ),
    );
    bloc.add(LoadFavoritedImages());

    // await pumpEventQueue();
    await tester.pumpWidgetBuilder(widget);
    await multiScreenGolden(tester, 'on_favorited_images_error');
  });
}
