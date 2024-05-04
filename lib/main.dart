import 'package:coffee_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brewing_screen/bloc/brewing_bloc.dart';
import 'coffee_app.dart';

void main() {
  setupDependencies();

  runApp(CoffeeApp());
}
