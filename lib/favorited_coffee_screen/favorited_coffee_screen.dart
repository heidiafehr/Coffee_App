import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritedCoffeeScreen extends StatelessWidget {
  const FavoritedCoffeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorited Coffee'),
      ),
      body: Text('Hey you made it to the favorites page!'),
    );
  }
}