import 'package:coffee_app/favorited_coffee_screen/widgets/display_favorited_images_catalog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/favorited_bloc.dart';

class FavoritedCoffeeScreen extends StatefulWidget {
  const FavoritedCoffeeScreen({super.key});

  @override
  _FavoritedCoffeeScreenState createState() => _FavoritedCoffeeScreenState();
}

class _FavoritedCoffeeScreenState extends State<FavoritedCoffeeScreen> {
  late List<String> displayedImageUrls = [];

  @override
  void initState() {
    super.initState();
    displayedImageUrls = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorited Coffee',
            style: Theme.of(context).textTheme.titleMedium),
      ),
      body: BlocBuilder<FavoritedBloc, FavoritedState>(
        builder: (context, state) {
          if (state is FavoritedImagesLoading) {
            return const CircularProgressIndicator();
          } else if (state is FavoritedImagesLoaded) {
            displayedImageUrls = state.favoritedImageCatalog;
            return DisplayFavoritedImagesCatalog(
                imageCatalog: displayedImageUrls);
          } else if (state is EmptyFavoritedImagesLoaded) {
            return const Text('uh oh! you have no favorites!');
          } else if (state is LoadFavoritedImagesError) {
            return Text('Error: ${state.errorMessage}');
          } else if (state is UnfavoritedImageSuccess) {
            displayedImageUrls.remove(state.imageUrl);
            return DisplayFavoritedImagesCatalog(
                imageCatalog: displayedImageUrls);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
