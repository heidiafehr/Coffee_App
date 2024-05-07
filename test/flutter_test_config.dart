import 'dart:async';

import 'package:coffee_app/coffee_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';


Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUp(() {
    testMode = true;
  });

  tearDown(() {
    testMode = false;
  });

  await loadAppFonts();
  return testMain();
}
