import 'package:coffee_app/favorited_coffee_screen/widgets/display_favorited_images_catalog.dart';
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
        title: const Text('Favorited Coffee'),
      ),
      body:
          BlocBuilder<FavoritedBloc, FavoritedState>(builder: (context, state) {
        if (state is FavoritedImagesLoading) {
          return const CircularProgressIndicator();
        } else if (state is FavoritedImagesLoaded) {
          return DisplayFavoritedImagesCatalog(
              favoriteImageUrls: state.favoritedImageCatalog);
        } else if (state is EmptyFavoritedImagesLoaded) {
          return const Text('uh oh! you have no favorites!');
        } else if (state is LoadFavoritedImagesError) {
          return Text('Error: ${state.errorMessage}');
        } else {
          return Container();
        }
      }),
    );
  }
}
