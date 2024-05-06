import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_app/favorited_coffee_screen/bloc/favorited_bloc.dart';
import 'package:coffee_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayFavoritedImagesCatalog extends StatelessWidget {
  const DisplayFavoritedImagesCatalog({required this.imageCatalog, super.key});

  final List<String> imageCatalog;

  @override
  Widget build(BuildContext context) {
    final favoritedBloc = context.read<FavoritedBloc>();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: imageCatalog.length,
      itemBuilder: (context, index) {
        final imageUrl = imageCatalog[index];

        return Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: imageCatalog[index],
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 1,
              right: 1,
              child: IconButton(
                icon: const Icon(Icons.favorite),
                color: Colors.red,
                onPressed: () {
                  favoritedBloc.add(UnfavoriteImage(imageUrl));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
