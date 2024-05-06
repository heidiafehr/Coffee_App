import 'package:coffee_app/coffee_app.dart';
import 'package:coffee_app/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  runApp(const CoffeeApp());
}
