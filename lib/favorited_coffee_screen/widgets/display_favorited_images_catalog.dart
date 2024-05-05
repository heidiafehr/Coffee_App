import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../service_locator.dart';
import '../bloc/favorited_bloc.dart';

class DisplayFavoritedImagesCatalog extends StatelessWidget {
  final List<String> imageCatalog;

  const DisplayFavoritedImagesCatalog({required this.imageCatalog, super.key});

  @override
  Widget build(BuildContext context) {
    final favoritedBloc = getIt<FavoritedBloc>();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: imageCatalog.length,
      itemBuilder: (context, index) {
        final imageUrl = imageCatalog[index];

        return Stack(children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: CachedNetworkImage(
              imageUrl: imageCatalog[index],
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 1,
            right: 1,
            child: IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                favoritedBloc.add(UnfavoriteImage(imageUrl));
              },
            ),
          ),
        ]);
      },
    );
  }
}
