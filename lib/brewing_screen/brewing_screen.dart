import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrewingScreen extends StatelessWidget {
  const BrewingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brewing Page'),
      ),
      body: Text('Hey you made it to the brewing page!'),
    );
  }
}