import 'package:coffee_app/brewing_screen/bloc/brewing_bloc.dart';
import 'package:coffee_app/brewing_screen/brewing_screen.dart';
import 'package:coffee_app/favorited_coffee_screen/bloc/favorited_bloc.dart';
import 'package:coffee_app/favorited_coffee_screen/favorited_coffee_screen.dart';
import 'package:coffee_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritedBloc = context.read<FavoritedBloc>();
    final brewingBloc = context.read<BrewingBloc>();

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                  bottomRight: Radius.circular(200),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 40, left: 20, right: 20),
                      child: Text(
                        'THE BREWING APP',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 70),
                      child: Icon(Icons.coffee, size: 250, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      // ignore: lines_longer_than_80_chars
                      'Brew up some new blends of coffee images. If you find an image you adore, simply tap the favorite button.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          brewingBloc.add(LoadCoffeeImage());
                          Navigator.push(
                            context,
                            MaterialPageRoute<BrewingScreen>(
                              builder: (context) => const BrewingScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Get Brewing',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () {
                          favoritedBloc.add(LoadFavoritedImages());
                          Navigator.push(
                            context,
                            MaterialPageRoute<FavoritedCoffeeScreen>(
                              builder: (context) =>
                                  const FavoritedCoffeeScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'See Favorites',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
