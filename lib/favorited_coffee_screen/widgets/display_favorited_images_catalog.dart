import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorited_bloc.dart';

class DisplayFavoritedImagesCatalog extends StatefulWidget {
  final List<String> favoriteImageUrls;

  const DisplayFavoritedImagesCatalog({
    required this.favoriteImageUrls,
    Key? key,
  }) : super(key: key);

  @override
  _DisplayFavoritedImagesCatalogState createState() =>
      _DisplayFavoritedImagesCatalogState();
}

class _DisplayFavoritedImagesCatalogState
    extends State<DisplayFavoritedImagesCatalog> {
  late List<String> displayedImageUrls;

  @override
  void initState() {
    super.initState();
    displayedImageUrls = List.from(widget.favoriteImageUrls);
  }

  // var _counter = 1;
  // void _removeImageUrl(imageUrl){
  //   print('here inside method');
  //   setState((){
  //     displayedImageUrls.remove(imageUrl);
  //     print(displayedImageUrls);
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final favoritedBloc = BlocProvider.of<FavoritedBloc>(context);

    return BlocListener<FavoritedBloc, FavoritedState>(
        listener: (context, state) {
          if (state is UnfavoritedImageSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Removed from favorites'),
                duration: Duration(seconds: 2),
              ),
            );
            //favoritedBloc.add(LoadFavoritedImages());
          } else if (state is UnfavoritedImageError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Removed from favorites'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('An unexpected error occurred'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
      child: displayedImageUrls.isEmpty
          ? const Center(child: Text('Uh oh! No favorites!'))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: displayedImageUrls.length,
              itemBuilder: (context, index) {
                final imageUrl = displayedImageUrls[index];

                return Stack(children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: CachedNetworkImage(
                      imageUrl: displayedImageUrls[index],
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
                        // _removeImageUrl(imageUrl);
                      },
                    ),
                  ),
                ]);
              },
            )
    );
  }
}
