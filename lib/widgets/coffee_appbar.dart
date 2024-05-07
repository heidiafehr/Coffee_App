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
          Navigator.popUntil(context, ModalRoute.withName('/menu_screen'));
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
