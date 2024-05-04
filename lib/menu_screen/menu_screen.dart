import 'package:coffee_app/favorited_coffee_screen/bloc/favorited_bloc.dart';
import 'package:coffee_app/favorited_coffee_screen/favorited_coffee_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../brewing_screen/bloc/brewing_bloc.dart';
import '../brewing_screen/brewing_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
                'Get Brewing'
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<BrewingBloc>(context).add(LoadCoffeeImage());
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
                BlocProvider.of<FavoritedBloc>(context).add(LoadFavoritedImages());
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