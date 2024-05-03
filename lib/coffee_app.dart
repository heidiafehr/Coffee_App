import 'package:coffee_app/brewing_screen/brewing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brewing_screen/bloc/brewing_bloc.dart';
import 'menu_screen/menu_screen.dart';

class CoffeeApp extends StatelessWidget {
  CoffeeApp({super.key});

  final _brewingBloc = BrewingBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: '/menu_screen',
      // routes: {
      //   '/menu_screen': (context) => const MenuScreen(),
      //   '/brewing_screen': (context) => BlocProvider(
      //         create: (context) => BrewingBloc(),
      //         child: BrewingScreen(),
      //       )
      // },
      // fucking bitch ass bitch ass fucking dumb ass bitch
      // so the issue that I cannot pass in my BlocProvider context through routes FOR WHATEVER REASON
      // so I have to have this as my home page???? why???????
      home: BlocProvider(
        create: (context) => BrewingBloc()..add(LoadCoffeeImage()),
        child: BrewingScreen(),
      ),
    );
  }
}
