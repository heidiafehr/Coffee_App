import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service_locator.dart';
import 'bloc/brewing_bloc.dart';

class BrewingScreen extends StatefulWidget {
  const BrewingScreen({super.key});

  @override
  State<BrewingScreen> createState() => _BrewingScreenState();
}

class _BrewingScreenState extends State<BrewingScreen>
    with SingleTickerProviderStateMixin {
  bool isFavorited = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  // late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1, curve: Curves.easeInOut),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFavorited = false;
        });
      }
    });
    // _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brewingBloc = getIt<BrewingBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Brewing Page',
            style: Theme.of(context).textTheme.titleMedium),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            width: 300,
            height: 300,
            child: BlocBuilder<BrewingBloc, BrewingState>(
              builder: (context, state) {
                if (state is BrewingLoading) {
                  return const CircularProgressIndicator();
                } else if (state is BrewingLoaded) {
                  return Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: state.imageUrl,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      if (isFavorited)
                        Center(
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: FadeTransition(
                              opacity: _opacityAnimation,
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 300,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                } else if (state is BrewingError) {
                  return Text('Error:; ${state.errorMessage}');
                }
                return Container();
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => brewingBloc.add(LoadCoffeeImage()),
            child: Text(
              'Brew Me Some Coffee',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final currentState = brewingBloc.state;
              if (currentState is BrewingLoaded && mounted) {
                brewingBloc
                    .add(AddCoffeeImageToFavorites(currentState.imageUrl));
                setState(
                  () {
                    isFavorited = true;
                  },
                );
                _controller.forward(from: 0);
                await Future.delayed(const Duration(seconds: 1));
                if (mounted) {
                  setState(() {
                    isFavorited = false;
                  });
                }
              }
            },
            child: Text(
              'Favorite',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}
