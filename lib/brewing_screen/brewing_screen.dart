import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_app/brewing_screen/bloc/brewing_bloc.dart';
import 'package:coffee_app/coffee_app.dart';
import 'package:coffee_app/widgets/coffee_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrewingScreen extends StatefulWidget {
  const BrewingScreen({super.key});

  @override
  State<BrewingScreen> createState() => _BrewingScreenState();
}

class _BrewingScreenState extends State<BrewingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brewingBloc = context.read<BrewingBloc>();

    return Scaffold(
      appBar: const CustomCoffeeAppBar(
        title: 'Brewing Page',
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: BlocBuilder<BrewingBloc, BrewingState>(
                builder: (context, state) {
                  if (state is BrewingLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BrewingLoaded) {
                    return Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: testMode
                              ? const Placeholder()
                              : CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: state.imageUrl,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                        ),
                        if (state.isFavorited)
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
                    return Text('Error: ${state.errorMessage}');
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    final currentState = brewingBloc.state;
                    if (currentState is BrewingLoaded) {
                      brewingBloc.add(
                        UpdateCoffeeImageToFavorites(
                          currentState.imageUrl,
                          isFavorited: !currentState.isFavorited,
                        ),
                      );
                    }
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child:
                        context.watch<BrewingBloc>().state is BrewingLoaded &&
                                (context.watch<BrewingBloc>().state
                                        as BrewingLoaded)
                                    .isFavorited
                            ? const Icon(
                                key: ValueKey<int>(1),
                                Icons.favorite,
                                color: Colors.red,
                                size: 25,
                              )
                            : const Icon(
                                key: ValueKey<int>(2),
                                Icons.favorite,
                                color: Colors.white,
                                size: 25,
                              ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
