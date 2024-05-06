import 'package:coffee_app/menu_screen/menu_screen.dart';
import 'package:flutter/material.dart';

class CustomCoffeeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomCoffeeAppBar({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 30,
        ),
      ),
      centerTitle: true,
      title: Padding(
        // ignore: use_named_constants
        padding: const EdgeInsets.symmetric(),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MenuScreen()),);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
