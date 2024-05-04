import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/favorited_bloc.dart';

class FavoritedCoffeeScreen extends StatelessWidget {
  const FavoritedCoffeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorited Coffee'),
      ),
      body:
          BlocBuilder<FavoritedBloc, FavoritedState>(builder: (context, state) {
        if (state is FavoritedImagesLoading) {
          return CircularProgressIndicator();
        } else if (state is FavoritedImagesLoaded) {
          final List<String> favoritedImageCatalog = state.favoritedImageCatalog;
          return Text('hey stuff loads?');
        } else if (state is EmptyFavoritedImagesLoaded) {
          return Text('uh oh! you have no favorites!');
        } else if (state is LoadFavoritedImagesError) {
          return Text('Error: ${state.errorMessage}');
        } else {
          return Container();
        }
      }),
    );
  }
}
