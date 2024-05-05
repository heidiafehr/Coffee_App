import 'package:coffee_app/favorited_coffee_screen/bloc/favorited_bloc.dart';
import 'package:coffee_app/favorited_coffee_screen/favorited_coffee_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../brewing_screen/bloc/brewing_bloc.dart';
import '../brewing_screen/brewing_screen.dart';
import '../service_locator.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritedBloc = getIt<FavoritedBloc>();
    final brewingBloc = getIt<BrewingBloc>();

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
                'Get Brewing'
            ),
            ElevatedButton(
              onPressed: () {
                brewingBloc.add(LoadCoffeeImage());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BrewingScreen()
                  )
                );
              },
              child: const Text(
                  'Get Brewing'
              ),
            ),
            ElevatedButton(
              onPressed: () {
                favoritedBloc.add(LoadFavoritedImages());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoritedCoffeeScreen()
                  ),
                );
              },
              child: const Text(
                  'See Favorites'
              ),
            ),
          ],
        ),
      ),
    );
  }
}