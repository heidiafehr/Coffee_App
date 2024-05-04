import 'package:coffee_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'coffee_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  runApp(CoffeeApp());
}
