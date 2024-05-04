import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayFavoritedImagesCatalog extends StatelessWidget {
  final List<String> favoriteImageUrls;

  const DisplayFavoritedImagesCatalog({
    required this.favoriteImageUrls,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: favoriteImageUrls.length,
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          imageUrl: favoriteImageUrls[index],
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        );
      },
    );
  }
}
