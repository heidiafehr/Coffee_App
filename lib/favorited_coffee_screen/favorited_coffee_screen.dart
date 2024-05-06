import 'package:coffee_app/favorited_coffee_screen/bloc/favorited_bloc.dart';
import 'package:coffee_app/favorited_coffee_screen/widgets/display_favorited_images_catalog.dart';
import 'package:coffee_app/favorited_coffee_screen/widgets/empty_favorited_catolog.dart';
import 'package:coffee_app/widgets/coffee_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: const CustomCoffeeAppBar(
        title: 'Favorited Coffee',
      ),
      body: BlocBuilder<FavoritedBloc, FavoritedState>(
        builder: (context, state) {
          if (state is FavoritedImagesLoading) {
            return const CircularProgressIndicator();
          } else if (state is FavoritedImagesLoaded) {
            displayedImageUrls = state.favoritedImageCatalog;
            return DisplayFavoritedImagesCatalog(
                imageCatalog: displayedImageUrls,);
          } else if (state is EmptyFavoritedImagesLoaded) {
            return const EmptyFavoritedCatalog();
          } else if (state is LoadFavoritedImagesError) {
            return Text('Error: ${state.errorMessage}');
          } else if (state is UnfavoritedImageSuccess) {
            displayedImageUrls.remove(state.imageUrl);
            return DisplayFavoritedImagesCatalog(
                imageCatalog: displayedImageUrls,);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
