import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../menu_screen/menu_screen.dart';

class CustomCoffeeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomCoffeeAppBar(
      {required this.title, required this.addNavigateBack, Key? key})
      : super(key: key);

  final String title;
  final bool addNavigateBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: addNavigateBack
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30.0,
              ),
            )
          : const SizedBox.shrink(),
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MenuScreen()));
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
