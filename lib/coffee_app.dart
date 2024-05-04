import 'package:coffee_app/brewing_screen/brewing_screen.dart';
import 'package:coffee_app/favorited_coffee_screen/favorited_coffee_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brewing_screen/bloc/brewing_bloc.dart';
import 'favorited_coffee_screen/bloc/favorited_bloc.dart';
import 'menu_screen/menu_screen.dart';

class CoffeeApp extends StatelessWidget {
  CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => BrewingBloc()..add(LoadCoffeeImage())),
        BlocProvider(
            create: (context) => FavoritedBloc()..add(LoadFavoritedImages())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/menu_screen',
        routes: {
          '/menu_screen': (context) => const MenuScreen(),
          '/brewing_screen': (context) => const BrewingScreen(),
          '/favorites_screen': (context) => const FavoritedCoffeeScreen(),
        },
        home: const MenuScreen(),
      ),
    );
  }
}
