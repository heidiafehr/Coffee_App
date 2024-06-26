import 'package:coffee_app/brewing_screen/bloc/brewing_bloc.dart';
import 'package:coffee_app/brewing_screen/brewing_screen.dart';
import 'package:coffee_app/favorited_coffee_screen/bloc/favorited_bloc.dart';
import 'package:coffee_app/favorited_coffee_screen/favorited_coffee_screen.dart';
import 'package:coffee_app/menu_screen/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

bool testMode = false;
class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FavoritedBloc()..add(LoadFavoritedImages()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            titleLarge: GoogleFonts.abrilFatface(
              fontSize: 50,
            ),
            titleMedium: GoogleFonts.abrilFatface(
              fontSize: 30,
            ),
            bodyMedium: GoogleFonts.courierPrime(fontSize: 15),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/menu_screen',
        routes: {
          '/menu_screen': (context) => const MenuScreen(),
          '/brewing_screen': (context) => BlocProvider(
                create: (_) => BrewingBloc()..add(LoadCoffeeImage()),
                child: const BrewingScreen(),
              ),
          '/favorites_screen': (context) => const FavoritedCoffeeScreen(),
        },
      ),
    );
  }
}
