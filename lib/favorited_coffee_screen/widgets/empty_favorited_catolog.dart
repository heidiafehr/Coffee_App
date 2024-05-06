import 'package:coffee_app/brewing_screen/bloc/brewing_bloc.dart';
import 'package:coffee_app/brewing_screen/brewing_screen.dart';
import 'package:coffee_app/service_locator.dart';
import 'package:flutter/material.dart';

class EmptyFavoritedCatalog extends StatelessWidget {
  const EmptyFavoritedCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    final brewingBloc = getIt<BrewingBloc>();
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            '''
Uh oh! Looks like you have no favorites. 
            \nWould you like to add some?
            ''',
            textAlign: TextAlign.center,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            brewingBloc.add(LoadCoffeeImage());
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BrewingScreen()),
            );
          },
          child: Text(
            'Get Brewing',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
