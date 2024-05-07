import 'package:flutter/material.dart';

class EmptyFavoritedCatalog extends StatelessWidget {
  const EmptyFavoritedCatalog({super.key});

  @override
  Widget build(BuildContext context) {
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
            Navigator.pushNamed(
              context,
              '/brewing_screen',
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
