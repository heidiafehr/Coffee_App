import 'package:coffee_app/favorited_coffee_screen/favorited_coffee_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../brewing_screen/brewing_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
                'Get Brewing'
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BrewingScreen()
                  )
                );
              },
              child: Text(
                  'Get Brewing'
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoritedCoffeeScreen()
                  ),
                );
              },
              child: Text(
                  'See Favorites'
              ),
            ),
          ],
        ),
      ),
    );
  }
}