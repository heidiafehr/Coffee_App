import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menu_screen/menu_screen.dart';

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/menu_screen',
      routes: {
        '/menu_screen': (context) => const MenuScreen(),
      },
    );
  }
}