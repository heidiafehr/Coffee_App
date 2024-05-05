import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/brewing_bloc.dart';

class BrewingScreen extends StatefulWidget {
  const BrewingScreen({super.key});

  @override
  State<BrewingScreen> createState() => _BrewingScreenState();
}

class _BrewingScreenState extends State<BrewingScreen> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final brewingBloc = BlocProvider.of<BrewingBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Brewing Page'),
      ),
      body: Center(
        child: Column(children: [
          BlocBuilder<BrewingBloc, BrewingState>(builder: (context, state) {
            if (state is BrewingLoading) {
              return const CircularProgressIndicator();
            } else if (state is BrewingLoaded) {
              return Column(children: [
                CachedNetworkImage(
                  imageUrl: state.imageUrl,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                if (isFavorited)
                  const Text('Added to Favorites!'),
              ]);
            } else if (state is BrewingError) {
              return Text('Error:; ${state.errorMessage}');
            }
            return Container();
          }),
          ElevatedButton(
            onPressed: () =>
                BlocProvider.of<BrewingBloc>(context).add(LoadCoffeeImage()),
            child: const Text('Brew Me Some Coffee'),
          ),
          ElevatedButton(
            onPressed: () async {
              final currentState = brewingBloc.state;
              if (currentState is BrewingLoaded && mounted) {
                BlocProvider.of<BrewingBloc>(context)
                    .add(AddCoffeeImageToFavorites(currentState.imageUrl));
                setState(() {
                  isFavorited = true;
                });
                await Future.delayed(const Duration(
                    seconds: 2)); // Delay to remove message or animation
                if (mounted) {
                  setState(() {
                    isFavorited = false;
                  });
                }
              }
            },
            child: const Text('Favorite'),
          ),
        ]),
      ),
    );
  }
}
